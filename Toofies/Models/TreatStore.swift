import Foundation
import Observation

@Observable
final class TreatStore {
    static let storageKey = "toofies.v2"
    static let legacyStorageKey = "toofies.v1"

    /// Every completed dessert-free day banks this many points.
    static let pointsPerCleanDay = 10
    /// With Apple Health connected, every 1,500 steps in a day earns +1 pt…
    static let stepsPerActivityPoint = 1_500
    /// …up to this daily cap (a 21k-step theme-park day banks +14).
    static let maxActivityPointsPerDay = 15
    /// Completing the daily step quest banks this bonus.
    static let questBonusPoints = 5
    /// Step-quest goal before there's a week of personal data to adapt to.
    static let defaultQuestGoal = 6_000
    /// On-plan streak milestones — dense through the first ten days, the
    /// habit-formation window where drop-off risk falls (see
    /// .planning/research/DUOLINGO-GAMIFICATION.md).
    static let streakMilestones: Set<Int> = [3, 7, 10, 14, 21, 30, 50, 75, 100, 150, 200, 365]

    /// What one dessert costs, in points (adjustable in settings).
    var dessertCost: Int = 30 {
        didSet { persist() }
    }
    var entries: [TreatEntry] = [] {
        didSet { persist() }
    }
    /// User opted in to step-based earning via Apple Health.
    private(set) var healthConnected = false
    /// Cached daily step totals (start-of-day → steps) so the balance is
    /// stable offline; refreshed from HealthKit on launch and on connect.
    private(set) var stepsByDay: [Date: Int] = [:]
    private(set) var installDate: Date = .now

    private var isLoading = false
    private let calendar = Calendar.current

    init() {
        load()
    }

    // MARK: - Logging

    func log(_ kind: TreatKind, at date: Date = .now) {
        entries.append(TreatEntry(kind: kind, date: date, pointsSpent: dessertCost))
    }

    func remove(_ entry: TreatEntry) {
        entries.removeAll { $0.id == entry.id }
    }

    // MARK: - Points economy
    // Earn-and-spend: each completed dessert-free day credits base points at
    // midnight; with Health connected, each completed day also credits step
    // points and any quest bonus (dessert or not — a walk always counts).
    // Each dessert debits the price in force when it was logged. The balance
    // is derived from the full history with a floor of zero, so an
    // unaffordable dessert is forgiven (never carried as debt) and deleting
    // an entry self-corrects.

    static func activityPoints(forSteps steps: Int) -> Int {
        min(steps / stepsPerActivityPoint, maxActivityPointsPerDay)
    }

    /// Full earn/spend history in time order: dessert debits at their
    /// timestamps, day credits at the following midnight.
    private func ledgerEvents(now: Date) -> [(date: Date, delta: Int)] {
        var events: [(date: Date, delta: Int)] = entries.map { ($0.date, -$0.pointsSpent) }
        let firstDay = calendar.startOfDay(for: min(installDate, entries.map(\.date).min() ?? installDate))
        let todayStart = calendar.startOfDay(for: now)
        var day = firstDay
        while day < todayStart {
            guard let next = calendar.date(byAdding: .day, value: 1, to: day) else { break }
            var credit = 0
            if desserts(from: day, to: next).isEmpty {
                credit += Self.pointsPerCleanDay
            }
            if healthConnected {
                credit += Self.activityPoints(forSteps: stepsByDay[day] ?? 0)
                if questCompleted(onDayStarting: day) {
                    credit += Self.questBonusPoints
                }
            }
            if credit > 0 {
                events.append((next, credit))
            }
            day = next
        }
        return events.sorted { $0.date < $1.date }
    }

    func balance(now: Date = .now) -> Int {
        ledgerEvents(now: now).reduce(0) { max(0, $0 + $1.delta) }
    }

    struct Availability {
        let balance: Int
        let cost: Int

        var affordable: Bool { balance >= cost }
        var bankedDesserts: Int { cost > 0 ? balance / cost : 0 }
        var pointsNeeded: Int { max(0, cost - balance) }
        var cleanDaysNeeded: Int {
            guard pointsNeeded > 0 else { return 0 }
            return Int((Double(pointsNeeded) / Double(TreatStore.pointsPerCleanDay)).rounded(.up))
        }
        var progress: Double {
            cost > 0 ? min(1, Double(balance) / Double(cost)) : 1
        }
    }

    func availability(now: Date = .now) -> Availability {
        Availability(balance: balance(now: now), cost: dessertCost)
    }

    /// Points today will bank at midnight, as things stand right now.
    func pendingPointsToday(now: Date = .now) -> Int {
        var pending = isCleanSoFarToday(now: now) ? Self.pointsPerCleanDay : 0
        if healthConnected {
            pending += Self.activityPoints(forSteps: todaySteps(now: now))
            if questCompleted(onDayStarting: calendar.startOfDay(for: now)) {
                pending += Self.questBonusPoints
            }
        }
        return pending
    }

    func todaySteps(now: Date = .now) -> Int {
        stepsByDay[calendar.startOfDay(for: now)] ?? 0
    }

    // MARK: - Daily step quest
    // A capped bonus quest — "walk your goal, bank +5 at midnight". The goal
    // adapts gently to the user's own recent week and is deterministic per
    // day, so past quest results replay identically in the balance fold.

    /// Step goal for the day: 105% of the median of the prior 7 days with
    /// data, clamped 3,000–12,000, rounded to the nearest 500.
    func questGoal(forDayStarting day: Date) -> Int {
        var samples: [Int] = []
        for offset in 1...7 {
            if let past = calendar.date(byAdding: .day, value: -offset, to: day),
               let steps = stepsByDay[past], steps > 0 {
                samples.append(steps)
            }
        }
        guard !samples.isEmpty else { return Self.defaultQuestGoal }
        let median = samples.sorted()[samples.count / 2]
        let clamped = min(12_000, max(3_000, Int(Double(median) * 1.05)))
        return (clamped + 250) / 500 * 500
    }

    func questCompleted(onDayStarting day: Date) -> Bool {
        guard healthConnected else { return false }
        return (stepsByDay[day] ?? 0) >= questGoal(forDayStarting: day)
    }

    func todayQuestGoal(now: Date = .now) -> Int {
        questGoal(forDayStarting: calendar.startOfDay(for: now))
    }

    // MARK: - Apple Health

    @MainActor
    func connectHealth() async {
        let service = StepSyncService()
        guard service.isAvailable else { return }
        do {
            try await service.requestAuthorization()
            healthConnected = true
            persist()
            await syncSteps()
        } catch {
            // Authorization sheet failed or was dismissed; stay disconnected.
        }
    }

    @MainActor
    func syncSteps(now: Date = .now) async {
        guard healthConnected else { return }
        let service = StepSyncService()
        let from = min(installDate, entries.map(\.date).min() ?? installDate)
        if let steps = try? await service.dailySteps(from: from, calendar: calendar) {
            stepsByDay = steps
            persist()
        }
    }

    // MARK: - Streaks & milestones
    // The streak the product celebrates is DAYS ON PLAN: clean days and
    // fully-earned dessert days both count — the earned dessert is the
    // product promise, so enjoying it must never break the streak. Only an
    // over-budget dessert pauses it, and even then: no debt, fresh start.

    /// Days on which a dessert outran the balance (the debit hit the floor).
    private func overspentDays(now: Date) -> Set<Date> {
        var balance = 0
        var days: Set<Date> = []
        for event in ledgerEvents(now: now) {
            let unclamped = balance + event.delta
            if event.delta < 0 && unclamped < 0 {
                days.insert(calendar.startOfDay(for: event.date))
            }
            balance = max(0, unclamped)
        }
        return days
    }

    func onPlanStreak(now: Date = .now) -> Int {
        let overspent = overspentDays(now: now)
        let firstDay = calendar.startOfDay(for: min(installDate, entries.map(\.date).min() ?? installDate))
        var streak = 0
        var day = calendar.startOfDay(for: now)
        while day >= firstDay, !overspent.contains(day) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }
        return streak
    }

    /// Non-nil while today's on-plan streak sits exactly on a milestone.
    func streakMilestoneToday(now: Date = .now) -> Int? {
        let streak = onPlanStreak(now: now)
        return Self.streakMilestones.contains(streak) ? streak : nil
    }

    // MARK: - Recency

    func lastDessertDate() -> Date? {
        entries.map(\.date).max()
    }

    /// Whole days since the most recent dessert (0 = today), nil if none logged.
    func daysSinceLastDessert(now: Date = .now) -> Int? {
        guard let last = lastDessertDate() else { return nil }
        return calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: last),
            to: calendar.startOfDay(for: now)
        ).day
    }

    func isCleanSoFarToday(now: Date = .now) -> Bool {
        let todayStart = calendar.startOfDay(for: now)
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: todayStart) else { return true }
        return desserts(from: todayStart, to: tomorrow).isEmpty
    }

    func nextMidnight(after now: Date = .now) -> Date {
        calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))
            ?? now.addingTimeInterval(86_400)
    }

    // MARK: - Chart data

    func lastSevenDays(now: Date = .now) -> [DayBucket] {
        let todayStart = calendar.startOfDay(for: now)
        return (0..<7).reversed().map { offset in
            let dayStart = calendar.date(byAdding: .day, value: -offset, to: todayStart) ?? todayStart
            let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart) ?? dayStart
            return DayBucket(
                id: dayStart,
                label: offset == 0 ? "Today" : dayStart.formatted(.dateTime.weekday(.abbreviated)),
                fullLabel: dayStart.formatted(.dateTime.weekday(.wide).month(.abbreviated).day()),
                entries: desserts(from: dayStart, to: dayEnd)
            )
        }
    }

    // MARK: - Helpers

    private func desserts(from start: Date, to end: Date) -> [TreatEntry] {
        entries.filter { $0.date >= start && $0.date < end }
    }

    // MARK: - Persistence

    private struct Snapshot: Codable {
        var dessertCost: Int
        var installDate: Date
        var entries: [TreatEntry]
        var healthConnected: Bool?
        var stepsByDay: [Date: Int]?
    }

    private struct LegacyEntry: Codable {
        let id: UUID
        let emoji: String
        let name: String
        let date: Date
    }

    private struct LegacySnapshot: Codable {
        var budget: Int
        var entries: [LegacyEntry]
    }

    private func persist() {
        guard !isLoading else { return }
        let snapshot = Snapshot(
            dessertCost: dessertCost,
            installDate: installDate,
            entries: entries,
            healthConnected: healthConnected,
            stepsByDay: stepsByDay
        )
        if let data = try? JSONEncoder().encode(snapshot) {
            UserDefaults.standard.set(data, forKey: Self.storageKey)
        }
    }

    private func load() {
        isLoading = true
        defer { isLoading = false }

        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: Self.storageKey),
           let snapshot = try? JSONDecoder().decode(Snapshot.self, from: data) {
            dessertCost = max(Self.pointsPerCleanDay, snapshot.dessertCost)
            installDate = snapshot.installDate
            entries = snapshot.entries
            healthConnected = snapshot.healthConnected ?? false
            stepsByDay = snapshot.stepsByDay ?? [:]
            return
        }

        // Migrate the weekly-budget prototype's data: old desserts carry no
        // point price (they predate the economy) and earning starts from the
        // earliest logged entry.
        if let data = defaults.data(forKey: Self.legacyStorageKey),
           let legacy = try? JSONDecoder().decode(LegacySnapshot.self, from: data) {
            entries = legacy.entries.map {
                TreatEntry(id: $0.id, emoji: $0.emoji, name: $0.name, date: $0.date, pointsSpent: 0)
            }
            installDate = entries.map(\.date).min() ?? .now
        }

        isLoading = false
        persist()
    }
}

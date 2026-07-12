import Foundation
import Observation

@Observable
final class TreatStore {
    static let storageKey = "toofies.v2"
    static let legacyStorageKey = "toofies.v1"

    /// Every completed dessert-free day banks this many points.
    static let pointsPerCleanDay = 10

    /// What one dessert costs, in points (adjustable in settings).
    var dessertCost: Int = 30 {
        didSet { persist() }
    }
    var entries: [TreatEntry] = [] {
        didSet { persist() }
    }
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
    // Earn-and-spend: each completed dessert-free day credits points at
    // midnight; each dessert debits the price in force when it was logged.
    // The balance is derived from the full history with a floor of zero, so
    // an unaffordable dessert is forgiven (never carried as debt) and
    // deleting an entry self-corrects — the freed day earns its credit back.

    func balance(now: Date = .now) -> Int {
        var events: [(date: Date, delta: Int)] = entries.map { ($0.date, -$0.pointsSpent) }
        let firstDay = calendar.startOfDay(for: min(installDate, entries.map(\.date).min() ?? installDate))
        let todayStart = calendar.startOfDay(for: now)
        var day = firstDay
        while day < todayStart {
            guard let next = calendar.date(byAdding: .day, value: 1, to: day) else { break }
            if desserts(from: day, to: next).isEmpty {
                events.append((next, Self.pointsPerCleanDay))
            }
            day = next
        }
        events.sort { $0.date < $1.date }
        return events.reduce(0) { max(0, $0 + $1.delta) }
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

    // MARK: - Recency & streaks

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

    /// Consecutive dessert-free days ending now. Today counts while it is
    /// still clean; a dessert today reads as zero and rebuilds tomorrow.
    func cleanStreak(now: Date = .now) -> Int {
        let firstDay = calendar.startOfDay(for: min(installDate, entries.map(\.date).min() ?? installDate))
        var streak = 0
        var day = calendar.startOfDay(for: now)
        while day >= firstDay {
            guard let next = calendar.date(byAdding: .day, value: 1, to: day),
                  desserts(from: day, to: next).isEmpty else { break }
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }
        return streak
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
        let snapshot = Snapshot(dessertCost: dessertCost, installDate: installDate, entries: entries)
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

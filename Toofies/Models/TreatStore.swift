import Foundation
import Observation

@Observable
final class TreatStore {
    static let storageKey = "toofies.v1"

    var budget: Int = 5 {
        didSet { persist() }
    }
    var entries: [TreatEntry] = [] {
        didSet { persist() }
    }

    private var isLoading = false

    /// Weeks start Monday at midnight, local time.
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 2
        return cal
    }()

    init() {
        load()
    }

    // MARK: - Logging

    func log(_ kind: TreatKind, at date: Date = .now) {
        entries.append(TreatEntry(kind: kind, date: date))
    }

    func remove(_ entry: TreatEntry) {
        entries.removeAll { $0.id == entry.id }
    }

    // MARK: - Weeks & pacing

    func currentWeek(containing date: Date) -> DateInterval {
        calendar.dateInterval(of: .weekOfYear, for: date)
            ?? DateInterval(start: date, duration: 7 * 86_400)
    }

    func entries(in interval: DateInterval) -> [TreatEntry] {
        entries.filter { $0.date >= interval.start && $0.date < interval.end }
    }

    func usedThisWeek(now: Date = .now) -> Int {
        entries(in: currentWeek(containing: now)).count
    }

    func remainingThisWeek(now: Date = .now) -> Int {
        max(0, budget - usedThisWeek(now: now))
    }

    var treatSpacing: TimeInterval {
        currentWeek(containing: .now).duration / Double(max(budget, 1))
    }

    /// Treats are paced evenly across the week: with a budget of B, the next
    /// treat unlocks one B-th of the week after the last one. A spent budget
    /// unlocks when the week resets.
    func nextTreatDate(now: Date = .now) -> Date {
        let week = currentWeek(containing: now)
        let thisWeek = entries(in: week)
        guard thisWeek.count < budget else { return week.end }
        guard let last = thisWeek.map(\.date).max() else { return now }
        let spacing = week.duration / Double(max(budget, 1))
        return min(last.addingTimeInterval(spacing), week.end)
    }

    // MARK: - Stats

    func dailyAverage(now: Date = .now) -> Double {
        let todayStart = calendar.startOfDay(for: now)
        guard let windowStart = calendar.date(byAdding: .day, value: -6, to: todayStart) else { return 0 }
        let count = entries.filter { $0.date >= windowStart }.count
        return Double(count) / 7
    }

    /// Consecutive completed weeks, walking back from last week, that stayed
    /// at or under budget. Stops at the week of the oldest logged treat.
    func weeksOnBudgetStreak(now: Date = .now) -> Int {
        guard let oldest = entries.map(\.date).min() else { return 0 }
        var streak = 0
        var probeStart = currentWeek(containing: now).start
        while let prevStart = calendar.date(byAdding: .weekOfYear, value: -1, to: probeStart) {
            let week = DateInterval(start: prevStart, end: probeStart)
            guard week.end > oldest, entries(in: week).count <= budget else { break }
            streak += 1
            probeStart = prevStart
        }
        return streak
    }

    func lastSevenDays(now: Date = .now) -> [DayBucket] {
        let todayStart = calendar.startOfDay(for: now)
        return (0..<7).reversed().map { offset in
            let dayStart = calendar.date(byAdding: .day, value: -offset, to: todayStart) ?? todayStart
            let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart) ?? dayStart
            let items = entries.filter { $0.date >= dayStart && $0.date < dayEnd }
            return DayBucket(
                id: dayStart,
                label: offset == 0 ? "Today" : dayStart.formatted(.dateTime.weekday(.abbreviated)),
                fullLabel: dayStart.formatted(.dateTime.weekday(.wide).month(.abbreviated).day()),
                entries: items
            )
        }
    }

    // MARK: - Persistence

    private struct Snapshot: Codable {
        var budget: Int
        var entries: [TreatEntry]
    }

    private func persist() {
        guard !isLoading else { return }
        let snapshot = Snapshot(budget: budget, entries: entries)
        if let data = try? JSONEncoder().encode(snapshot) {
            UserDefaults.standard.set(data, forKey: Self.storageKey)
        }
    }

    private func load() {
        isLoading = true
        defer { isLoading = false }
        guard let data = UserDefaults.standard.data(forKey: Self.storageKey),
              let snapshot = try? JSONDecoder().decode(Snapshot.self, from: data) else { return }
        budget = max(1, snapshot.budget)
        entries = snapshot.entries
    }
}

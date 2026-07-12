import Foundation
import HealthKit

/// Read-only bridge to Apple Health: daily step totals, used to credit
/// activity points. Toofies never writes health data.
struct StepSyncService {
    private let healthStore = HKHealthStore()

    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    func requestAuthorization() async throws {
        let steps = HKQuantityType(.stepCount)
        try await healthStore.requestAuthorization(toShare: [], read: [steps])
    }

    /// Daily step totals from `start` through now, keyed by local start-of-day.
    /// Days Health has no data for are simply absent.
    func dailySteps(from start: Date, calendar: Calendar) async throws -> [Date: Int] {
        let steps = HKQuantityType(.stepCount)
        let anchor = calendar.startOfDay(for: start)
        let descriptor = HKStatisticsCollectionQueryDescriptor(
            predicate: HKSamplePredicate.quantitySample(
                type: steps,
                predicate: HKQuery.predicateForSamples(withStart: anchor, end: nil)
            ),
            options: .cumulativeSum,
            anchorDate: anchor,
            intervalComponents: DateComponents(day: 1)
        )
        let collection = try await descriptor.result(for: healthStore)

        var result: [Date: Int] = [:]
        collection.enumerateStatistics(from: anchor, to: .now) { stats, _ in
            if let sum = stats.sumQuantity() {
                let day = calendar.startOfDay(for: stats.startDate)
                result[day] = Int(sum.doubleValue(for: .count()))
            }
        }
        return result
    }
}

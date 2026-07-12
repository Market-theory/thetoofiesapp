import Charts
import SwiftUI

struct WeeklyChartCard: View {
    @Environment(TreatStore.self) private var store
    @State private var selectedLabel: String?

    var body: some View {
        let days = store.lastSevenDays()
        let maxCount = max(1, days.map(\.count).max() ?? 1)
        let tickStep = max(1, Int((Double(maxCount) / 4).rounded(.up)))
        let yMax = Int((Double(maxCount) / Double(tickStep)).rounded(.up)) * tickStep

        Card(title: "Treats per day, last 7 days") {
            Chart(days) { day in
                BarMark(
                    x: .value("Day", day.label),
                    y: .value("Treats", day.count),
                    width: .fixed(24)
                )
                .foregroundStyle(Color.series)
                .cornerRadius(4)
                .annotation(position: .top, spacing: 4) {
                    // selective direct label: only the busiest day
                    if day.count == maxCount && day.count > 0 {
                        Text("\(day.count)")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .chartXSelection(value: $selectedLabel)
            .chartYScale(domain: 0...yMax)
            .chartYAxis {
                AxisMarks(values: Array(stride(from: 0, through: yMax, by: tickStep)))
            }
            .frame(height: 200)

            if let selectedLabel,
               let day = days.first(where: { $0.label == selectedLabel }) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(day.fullLabel) — \(day.count) treat\(day.count == 1 ? "" : "s")")
                        .font(.caption.weight(.semibold))
                    if !day.entries.isEmpty {
                        Text(day.entries.map { "\($0.emoji) \($0.name)" }.joined(separator: ", "))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            } else {
                Text("Tap a bar for details")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

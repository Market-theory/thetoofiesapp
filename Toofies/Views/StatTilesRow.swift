import SwiftUI

struct StatTilesRow: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        HStack(spacing: 8) {
            StatTile(
                label: "Treats left this week",
                value: "\(store.remainingThisWeek())"
            )
            StatTile(
                label: "Daily average, 7 days",
                value: store.dailyAverage().formatted(.number.precision(.fractionLength(1)))
            )
            StatTile(
                label: "Weeks on budget",
                value: "\(store.weeksOnBudgetStreak())"
            )
        }
    }
}

private struct StatTile: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
            Text(value)
                .font(.title2.weight(.semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .frame(maxHeight: .infinity)
        .background(
            Color(.secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
    }
}

import SwiftUI

struct StatTilesRow: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        HStack(spacing: 8) {
            StatTile(
                label: "Points balance",
                value: "\(store.balance())"
            )
            StatTile(
                label: "Last dessert",
                value: lastDessertText
            )
            StatTile(
                label: "Days on plan",
                value: "\(store.onPlanStreak())"
            )
        }
    }

    private var lastDessertText: String {
        guard let days = store.daysSinceLastDessert() else { return "—" }
        switch days {
        case 0: return "Today"
        case 1: return "1d ago"
        default: return "\(days)d ago"
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

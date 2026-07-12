import SwiftUI

struct BudgetMeterCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        let used = store.usedThisWeek()
        let fraction = store.budget > 0 ? Double(used) / Double(store.budget) : 1
        let state = MeterState(fraction: fraction)

        Card(title: "This week's budget") {
            HStack(alignment: .firstTextBaseline) {
                Text("\(used) of \(store.budget) treats")
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Text("resets Monday")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(state.tint.opacity(0.18))
                    Capsule()
                        .fill(state.tint)
                        .frame(width: geo.size.width * min(1, fraction))
                }
            }
            .frame(height: 10)
            .accessibilityElement()
            .accessibilityLabel("Weekly treat budget")
            .accessibilityValue("\(used) of \(store.budget) treats used")

            Label {
                Text(state.note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } icon: {
                Image(systemName: state.icon)
                    .font(.caption)
                    .foregroundStyle(state.tint)
            }
        }
    }
}

private struct MeterState {
    let tint: Color
    let icon: String
    let note: String

    init(fraction: Double) {
        if fraction >= 1 {
            tint = .statusCritical
            icon = "nosign"
            note = "Budget spent — hold out for Monday."
        } else if fraction >= 0.7 {
            tint = .statusWarning
            icon = "exclamationmark.triangle.fill"
            note = "Getting close — make the rest count."
        } else {
            tint = .series
            icon = "checkmark.circle.fill"
            note = "Comfortably on pace."
        }
    }
}

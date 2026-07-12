import SwiftUI

/// Progress toward the next dessert. The economy is positive-sum, so the
/// meter only ever fills up — there is no warning/danger state to escalate.
struct PointsMeterCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        let avail = store.availability()
        let tint: Color = avail.affordable ? .goodText : .series

        Card(title: "Points") {
            HStack(alignment: .firstTextBaseline) {
                Text("\(avail.balance) pts")
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Text("\(avail.cost) pts per dessert")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(tint.opacity(0.18))
                    Capsule()
                        .fill(tint)
                        .frame(width: geo.size.width * avail.progress)
                }
            }
            .frame(height: 10)
            .accessibilityElement()
            .accessibilityLabel("Points toward next dessert")
            .accessibilityValue("\(avail.balance) of \(avail.cost) points")

            Label {
                Text(note(for: avail))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } icon: {
                Image(systemName: avail.affordable ? "checkmark.seal.fill" : "hourglass")
                    .font(.caption)
                    .foregroundStyle(tint)
            }
        }
    }

    private func note(for avail: TreatStore.Availability) -> String {
        if avail.affordable {
            return "Fully banked — enjoy one, then keep earning."
        }
        return "+\(TreatStore.pointsPerCleanDay) pts for every dessert-free day."
    }
}

import SwiftUI

/// Step-based earning: connect Apple Health and movement banks points —
/// dessert or not, a walk always counts.
struct ActivityCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        Card(title: "Activity") {
            if store.healthConnected {
                let steps = store.todaySteps()
                let bonus = TreatStore.activityPoints(forSteps: steps)

                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(steps.formatted()) steps today")
                            .font(.subheadline.weight(.semibold))
                        Text("+\(bonus) pts banking at midnight")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "figure.walk")
                        .font(.title3)
                        .foregroundStyle(Color.series)
                }

                Text("1 pt per \(TreatStore.stepsPerActivityPoint.formatted()) steps, up to +\(TreatStore.maxActivityPointsPerDay)/day — it counts even on dessert days.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            } else {
                Text("Walk your way to dessert: connect Apple Health and every \(TreatStore.stepsPerActivityPoint.formatted()) steps earns +1 pt (up to +\(TreatStore.maxActivityPointsPerDay)/day), even on dessert days.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Button {
                    Task { await store.connectHealth() }
                } label: {
                    Label("Connect Apple Health", systemImage: "heart.fill")
                        .font(.subheadline.weight(.medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
                .tint(Color.series)
            }
        }
    }
}

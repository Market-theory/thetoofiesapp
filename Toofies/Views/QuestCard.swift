import SwiftUI

/// The daily step quest: walk your goal, bank a +5 bonus at midnight. The
/// goal adapts gently to the user's own recent week; quest variety and
/// events are the designed answer to gamification's documented novelty
/// decay (see .planning/research/DUOLINGO-GAMIFICATION.md).
struct QuestCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        Card(title: "Today's quest") {
            if store.healthConnected {
                let goal = store.todayQuestGoal()
                let steps = store.todaySteps()
                let done = steps >= goal
                let progress = goal > 0 ? min(1, Double(steps) / Double(goal)) : 0
                let tint: Color = done ? .goodText : .series

                HStack(alignment: .firstTextBaseline) {
                    Text(done ? "Quest complete! 🦷🎉" : "Walk \(goal.formatted()) steps")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text(done ? "+\(TreatStore.questBonusPoints) pts tonight" : "\(steps.formatted()) / \(goal.formatted())")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .monospacedDigit()
                }

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(tint.opacity(0.18))
                        Capsule()
                            .fill(tint)
                            .frame(width: geo.size.width * progress)
                    }
                }
                .frame(height: 10)
                .accessibilityElement()
                .accessibilityLabel("Daily step quest")
                .accessibilityValue("\(steps) of \(goal) steps")

                Text(done
                     ? "Bonus banked at midnight. Toofie's impressed."
                     : "Finish for a +\(TreatStore.questBonusPoints) pt bonus — the goal adapts to your own recent week.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            } else {
                Text("Connect Apple Health in the Activity card to unlock a daily step quest worth +\(TreatStore.questBonusPoints) bonus pts.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

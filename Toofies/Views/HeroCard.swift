import SwiftUI

/// The one answer the app leads with: "Go ahead!" or a live countdown to the
/// moment the next treat unlocks.
struct HeroCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let now = context.date
            let next = store.nextTreatDate(now: now)
            let used = store.usedThisWeek(now: now)
            let left = store.remainingThisWeek(now: now)
            let unlocked = next <= now

            VStack(spacing: 8) {
                Text(label(unlocked: unlocked, used: used))
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)

                if unlocked {
                    Text("Go ahead! 🎉")
                        .font(.system(size: 42, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.goodText)
                } else {
                    Text(Format.countdown(from: now, to: next))
                        .font(.system(size: 42, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                }

                Text(subtitle(unlocked: unlocked, used: used, left: left))
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .padding(.horizontal, 20)
            .background(
                Color(.secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
        }
    }

    private func label(unlocked: Bool, used: Int) -> String {
        if unlocked { return "Treat check" }
        if used >= store.budget { return "Budget spent — next treat when the week resets" }
        return "Next treat unlocks in"
    }

    private func subtitle(unlocked: Bool, used: Int, left: Int) -> String {
        let treats = { (n: Int) in "\(n) treat\(n == 1 ? "" : "s")" }
        if unlocked {
            return used == 0
                ? "Fresh week — you have \(treats(left)) to enjoy."
                : "\(treats(left)) left this week. Savor it."
        }
        if used >= store.budget {
            return "Your \(store.budget)-treat week starts over Monday at midnight."
        }
        return "\(treats(left)) left this week, paced \(Format.duration(store.treatSpacing)) apart."
    }
}

import SwiftUI

/// The answer the app leads with: "Treat yourself!" when the balance covers a
/// dessert, otherwise how many points (≈ clean days) stand between you and
/// the next one — plus a live countdown to tonight's +10 credit.
struct HeroCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let now = context.date
            let avail = store.availability(now: now)
            let cleanToday = store.isCleanSoFarToday(now: now)

            VStack(spacing: 8) {
                Text(avail.affordable ? "Treat check" : "Next dessert")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)

                if avail.affordable {
                    Text("Treat yourself! 🎉")
                        .font(.system(size: 42, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.goodText)
                } else {
                    Text("\(avail.pointsNeeded) pts to go")
                        .font(.system(size: 42, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                }

                Text(subtitle(avail: avail, cleanToday: cleanToday, now: now))
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

    private func subtitle(avail: TreatStore.Availability, cleanToday: Bool, now: Date) -> String {
        if avail.affordable {
            let desserts = "\(avail.bankedDesserts) dessert\(avail.bankedDesserts == 1 ? "" : "s")"
            return "\(avail.balance) points banked — enough for \(desserts). You've earned it."
        }
        let days = "\(avail.cleanDaysNeeded) clean day\(avail.cleanDaysNeeded == 1 ? "" : "s")"
        if cleanToday {
            let untilMidnight = Format.countdown(from: now, to: store.nextMidnight(after: now))
            return "About \(days) away — today banks +\(TreatStore.pointsPerCleanDay) pts at midnight (in \(untilMidnight))."
        }
        return "Earning resumes tomorrow — about \(days) to go."
    }
}

import SwiftUI

struct SettingsCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        @Bindable var store = store

        Card {
            Stepper(value: $store.dessertCost, in: 10...100, step: 5) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dessert cost")
                        .font(.subheadline)
                    Text("\(store.dessertCost) pts ≈ \(cleanDays) clean day\(cleanDays == 1 ? "" : "s") per dessert")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private var cleanDays: Int {
        Int((Double(store.dessertCost) / Double(TreatStore.pointsPerCleanDay)).rounded(.up))
    }
}

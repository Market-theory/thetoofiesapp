import SwiftUI

struct SettingsCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        @Bindable var store = store

        Card {
            Stepper(value: $store.budget, in: 1...50) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Weekly treat budget")
                        .font(.subheadline)
                    Text("\(store.budget) treats, one unlocks every \(Format.duration(store.treatSpacing))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

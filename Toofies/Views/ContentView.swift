import SwiftUI

struct ContentView: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                HeroCard()
                BudgetMeterCard()
                QuickLogCard()
                StatTilesRow()
                WeeklyChartCard()
                HistoryCard()
                SettingsCard()
            }
            .padding(16)
        }
        .background(Color(.systemGroupedBackground))
    }

    private var header: some View {
        HStack(spacing: 10) {
            Text("🦷")
                .font(.system(size: 30))
            VStack(alignment: .leading, spacing: 2) {
                Text("Toofies")
                    .font(.title2.weight(.bold))
                Text("Know exactly when you can enjoy the sweet things in life")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    ContentView()
        .environment(TreatStore())
}

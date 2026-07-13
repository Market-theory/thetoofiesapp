import SwiftUI

struct ContentView: View {
    @Environment(TreatStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                HeroCard()
                PointsMeterCard()
                QuickLogCard()
                ActivityCard()
                QuestCard()
                StatTilesRow()
                WeeklyChartCard()
                HistoryCard()
                SettingsCard()
            }
            .padding(16)
        }
        .background(Color(.systemGroupedBackground))
        .task {
            await store.syncSteps()
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                Task { await store.syncSteps() }
            }
        }
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

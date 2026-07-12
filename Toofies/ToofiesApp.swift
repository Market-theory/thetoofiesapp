import SwiftUI

@main
struct ToofiesApp: App {
    @State private var store = TreatStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}

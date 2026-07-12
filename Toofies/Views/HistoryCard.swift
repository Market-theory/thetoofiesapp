import SwiftUI

struct HistoryCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        let week = store.entries(in: store.currentWeek(containing: .now))
            .sorted { $0.date > $1.date }

        Card(title: "This week's treats") {
            if week.isEmpty {
                Text("Nothing yet — a clean slate. 🦷✨")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 0) {
                    ForEach(week) { entry in
                        HStack(spacing: 10) {
                            Text(entry.emoji)
                                .font(.title3)
                            Text(entry.name)
                                .font(.subheadline.weight(.medium))
                            Spacer()
                            Text(entry.date.formatted(.dateTime.weekday(.abbreviated).hour().minute()))
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                            Button {
                                withAnimation {
                                    store.remove(entry)
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                                    .padding(6)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Delete \(entry.name)")
                        }
                        .padding(.vertical, 10)

                        if entry.id != week.last?.id {
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

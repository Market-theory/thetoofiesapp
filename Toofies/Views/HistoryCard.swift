import SwiftUI

struct HistoryCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        let recent = Array(store.entries.sorted { $0.date > $1.date }.prefix(10))

        Card(title: "Recent desserts") {
            if recent.isEmpty {
                Text("Nothing yet — every day you wait banks +\(TreatStore.pointsPerCleanDay) pts. 🦷✨")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 0) {
                    ForEach(recent) { entry in
                        HStack(spacing: 10) {
                            Text(entry.emoji)
                                .font(.title3)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(entry.name)
                                    .font(.subheadline.weight(.medium))
                                if entry.pointsSpent > 0 {
                                    Text("−\(entry.pointsSpent) pts")
                                        .font(.caption2)
                                        .foregroundStyle(.tertiary)
                                }
                            }
                            Spacer()
                            Text(entry.date.formatted(.dateTime.month(.abbreviated).day().hour().minute()))
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

                        if entry.id != recent.last?.id {
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

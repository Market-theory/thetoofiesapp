import SwiftUI

struct QuickLogCard: View {
    @Environment(TreatStore.self) private var store

    var body: some View {
        Card(title: "Had a treat? Log it") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 88), spacing: 8)], spacing: 8) {
                ForEach(TreatKind.allCases) { kind in
                    Button {
                        store.log(kind)
                    } label: {
                        VStack(spacing: 4) {
                            Text(kind.emoji)
                                .font(.system(size: 26))
                            Text(kind.name)
                                .font(.caption.weight(.medium))
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(.quaternary)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
            .sensoryFeedback(.impact(weight: .light), trigger: store.entries.count)
        }
    }
}

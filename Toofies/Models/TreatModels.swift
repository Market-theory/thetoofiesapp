import Foundation

enum TreatKind: String, CaseIterable, Identifiable {
    case cookie, cake, iceCream, chocolate, donut, candy, pie, cupcake

    var id: String { rawValue }

    var name: String {
        switch self {
        case .cookie: "Cookie"
        case .cake: "Cake"
        case .iceCream: "Ice cream"
        case .chocolate: "Chocolate"
        case .donut: "Donut"
        case .candy: "Candy"
        case .pie: "Pie"
        case .cupcake: "Cupcake"
        }
    }

    var emoji: String {
        switch self {
        case .cookie: "🍪"
        case .cake: "🍰"
        case .iceCream: "🍦"
        case .chocolate: "🍫"
        case .donut: "🍩"
        case .candy: "🍬"
        case .pie: "🥧"
        case .cupcake: "🧁"
        }
    }
}

struct TreatEntry: Identifiable, Codable, Equatable {
    let id: UUID
    let emoji: String
    let name: String
    let date: Date

    init(kind: TreatKind, date: Date = .now) {
        self.id = UUID()
        self.emoji = kind.emoji
        self.name = kind.name
        self.date = date
    }
}

struct DayBucket: Identifiable {
    let id: Date
    let label: String
    let fullLabel: String
    let entries: [TreatEntry]

    var count: Int { entries.count }
}

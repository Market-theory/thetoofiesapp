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
    /// The dessert's price in points at the moment it was logged (0 for
    /// entries migrated from the pre-economy prototype).
    let pointsSpent: Int

    init(kind: TreatKind, date: Date = .now, pointsSpent: Int) {
        self.init(id: UUID(), emoji: kind.emoji, name: kind.name, date: date, pointsSpent: pointsSpent)
    }

    init(id: UUID, emoji: String, name: String, date: Date, pointsSpent: Int) {
        self.id = id
        self.emoji = emoji
        self.name = name
        self.date = date
        self.pointsSpent = pointsSpent
    }
}

struct DayBucket: Identifiable {
    let id: Date
    let label: String
    let fullLabel: String
    let entries: [TreatEntry]

    var count: Int { entries.count }
}

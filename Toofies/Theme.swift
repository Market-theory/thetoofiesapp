import SwiftUI
import UIKit

extension Color {
    /// Single data-series hue, validated for both light and dark surfaces.
    static let series = Color(lightHex: 0x2A78D6, darkHex: 0x3987E5)
    static let statusWarning = Color(lightHex: 0xFAB219, darkHex: 0xFAB219)
    static let statusCritical = Color(lightHex: 0xD03B3B, darkHex: 0xD03B3B)
    static let goodText = Color(lightHex: 0x006300, darkHex: 0x0CA30C)

    init(lightHex: UInt32, darkHex: UInt32) {
        self.init(uiColor: UIColor { traits in
            UIColor(hexValue: traits.userInterfaceStyle == .dark ? darkHex : lightHex)
        })
    }
}

extension UIColor {
    convenience init(hexValue: UInt32) {
        self.init(
            red: CGFloat((hexValue >> 16) & 0xFF) / 255,
            green: CGFloat((hexValue >> 8) & 0xFF) / 255,
            blue: CGFloat(hexValue & 0xFF) / 255,
            alpha: 1
        )
    }
}

enum Format {
    static func duration(_ seconds: TimeInterval) -> String {
        let total = max(0, Int(seconds.rounded(.up)))
        let days = total / 86_400
        let hours = (total % 86_400) / 3_600
        let minutes = (total % 3_600) / 60
        let secs = total % 60
        if days > 0 { return "\(days)d \(hours)h" }
        if hours > 0 { return "\(hours)h \(minutes)m" }
        return String(format: "%dm %02ds", minutes, secs)
    }

    static func countdown(from now: Date, to target: Date) -> String {
        duration(target.timeIntervalSince(now))
    }
}

struct Card<Content: View>: View {
    var title: String? = nil
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            Color(.secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
    }
}

import UIKit

/// Constants that indicate the style associated with the app's user interface.
public enum UserInterfaceStyle: String, Encodable {
    /// The dark interface style.
    case dark
    /// The light interface style.
    case light
    /// An undefined user interface style.
    case undefined
}

extension UserInterfaceStyle {

    init(_ userInterfaceStyle: UIUserInterfaceStyle) {
        switch userInterfaceStyle {
        case .dark:
            self = .dark
        case .light:
            self = .light
        case .unspecified:
            self = .undefined
        @unknown default:
            self = .undefined
        }
    }
}

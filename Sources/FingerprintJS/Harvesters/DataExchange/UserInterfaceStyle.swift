import UIKit

public enum UserInterfaceStyle: String {
    case dark
    case light
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

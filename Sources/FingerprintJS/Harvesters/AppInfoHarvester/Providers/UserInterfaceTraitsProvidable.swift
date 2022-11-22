import UIKit

protocol UserInterfaceTraitsProvidable {
    var userInterfaceStyle: UIUserInterfaceStyle { get }
}

extension UITraitCollection: UserInterfaceTraitsProvidable {}

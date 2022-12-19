import UIKit

protocol UserInterfaceTraitsProviding {
    var userInterfaceStyle: UIUserInterfaceStyle { get }
}

extension UITraitCollection: UserInterfaceTraitsProviding {}

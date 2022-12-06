import UIKit

protocol ScreenInfoProviding {
    var nativeBounds: CGRect { get }
    var nativeScale: CGFloat { get }
}

extension UIScreen: ScreenInfoProviding {}

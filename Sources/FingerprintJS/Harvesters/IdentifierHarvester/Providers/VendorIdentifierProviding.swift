import UIKit

protocol VendorIdentifierProviding {
    var identifierForVendor: UUID? { get }
}

extension UIDevice: VendorIdentifierProviding {}

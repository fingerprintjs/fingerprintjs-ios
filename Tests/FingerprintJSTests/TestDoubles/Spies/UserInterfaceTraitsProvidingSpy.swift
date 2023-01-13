import UIKit

@testable import FingerprintJS

final class UserInterfaceTraitsProvidingSpy: UserInterfaceTraitsProviding {

    var userInterfaceStyleReturnValue: UIUserInterfaceStyle = .unspecified

    private(set) var userInterfaceStyleCallCount: Int = .zero

    var userInterfaceStyle: UIUserInterfaceStyle {
        userInterfaceStyleCallCount += 1
        return userInterfaceStyleReturnValue
    }
}

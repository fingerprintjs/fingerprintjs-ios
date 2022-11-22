import UIKit

@testable import FingerprintJS

final class UserInterfaceTraitsProvidableSpy: UserInterfaceTraitsProvidable {

    var userInterfaceStyleReturnValue: UIUserInterfaceStyle = .unspecified

    private(set) var userInterfaceStyleCallCount: Int = .zero

    var userInterfaceStyle: UIUserInterfaceStyle {
        userInterfaceStyleCallCount += 1
        return userInterfaceStyleReturnValue
    }
}

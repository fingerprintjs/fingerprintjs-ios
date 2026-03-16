@testable import FingerprintJS

final class LowPowerModeProvidingSpy: LowPowerModeProviding {

    var isLowPowerModeEnabledReturnValue: Bool = false

    private(set) var isLowPowerModeEnabledCallCount: Int = .zero

    var isLowPowerModeEnabled: Bool {
        isLowPowerModeEnabledCallCount += 1
        return isLowPowerModeEnabledReturnValue
    }
}

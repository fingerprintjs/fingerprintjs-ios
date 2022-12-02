import Foundation

@testable import FingerprintJS

final class TimeZoneProvidableSpy: TimeZoneProvidable {

    var currentReturnValue: TimeZone = .current

    private(set) var currentCallCount: Int = .zero

    var current: TimeZone {
        currentCallCount += 1
        return currentReturnValue
    }
}

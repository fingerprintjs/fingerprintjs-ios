@testable import FingerprintJS

final class TimeZoneInfoProvidingSpy: TimeZoneInfoProviding {

    var identifierReturnValue: String = ""

    private(set) var identifierCallCount: Int = .zero

    var identifier: String {
        identifierCallCount += 1
        return identifierReturnValue
    }
}

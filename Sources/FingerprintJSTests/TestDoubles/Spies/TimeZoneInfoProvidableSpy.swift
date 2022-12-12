@testable import FingerprintJS

final class TimeZoneInfoProvidableSpy: TimeZoneInfoProvidable {

    var identifierReturnValue: String = ""

    private(set) var identifierCallCount: Int = .zero

    var identifier: String {
        identifierCallCount += 1
        return identifierReturnValue
    }
}

import Foundation

@testable import FingerprintJS

final class LocaleInfoProvidableSpy: LocaleInfoProvidable {

    var identifierReturnValue: String = ""

    private(set) var identifierCallCount: Int = .zero

    var identifier: String {
        identifierCallCount += 1
        return identifierReturnValue
    }
}

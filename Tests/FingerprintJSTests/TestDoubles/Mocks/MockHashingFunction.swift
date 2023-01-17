import Foundation

@testable import FingerprintJS

class MockFingerprintFunction: FingerprintFunction {
    var fakeHash: String = ""

    func fingerprint(data: Data) -> String {
        return fakeHash
    }
}

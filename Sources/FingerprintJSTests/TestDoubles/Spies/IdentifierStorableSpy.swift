import Foundation

@testable import FingerprintJS

final class IdentifierStorableSpy: IdentifierStorable {
    private(set) var storeIdentifierCallCount: Int = .zero
    private(set) var loadIdentifierCallCount: Int = .zero

    private(set) var storeIdentifierInputs: [String: UUID] = [:]

    var loadIdentifierReturnDictionary: [String: UUID] = [:]

    func storeIdentifier(_ identifier: UUID, for key: String) {
        storeIdentifierInputs[key] = identifier
        storeIdentifierCallCount += 1
    }

    func loadIdentifier(for key: String) -> UUID? {
        loadIdentifierCallCount += 1
        return loadIdentifierReturnDictionary[key]
    }
}

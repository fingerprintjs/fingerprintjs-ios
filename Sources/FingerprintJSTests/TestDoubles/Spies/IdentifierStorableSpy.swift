@testable import FingerprintJS

final class IdentifierStorableSpy: IdentifierStorable {
    var storeIdentifierInputs: [String: UUID] = [:]

    var loadIdentifierReturnValue: UUID? = nil
    var loadIdentifierReturnDictionary: [String: UUID] = [:]

    var storeIdentifierCallCount: Int = .zero
    var loadIdentifierCallCount: Int = .zero

    func storeIdentifier(_ identifier: UUID, for key: String) {
        storeIdentifierInputs[key] = identifier
        storeIdentifierCallCount += 1
    }

    func loadIdentifier(for key: String) -> UUID? {
        loadIdentifierCallCount += 1
        guard let loadIdentifierReturnValue = loadIdentifierReturnValue else {
            return loadIdentifierReturnDictionary[key]
        }
        return loadIdentifierReturnValue
    }
}

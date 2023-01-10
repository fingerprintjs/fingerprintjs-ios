import UIKit

protocol IdentifierHarvesting {
    var vendorIdentifier: UUID? { get }
}

struct IdentifierHarvester {
    private let vendorIdentifierLegacyKey = "vendorIdentifier"
    private let vendorIdentifierKey = "id.vendor"

    private let identifierStorage: IdentifierStorable
    private let vendorIdentifierProvider: VendorIdentifierProviding

    init(
        identifierStorage: IdentifierStorable,
        vendorIdentifierProvider: VendorIdentifierProviding
    ) {
        self.identifierStorage = identifierStorage
        self.vendorIdentifierProvider = vendorIdentifierProvider
    }
}

extension IdentifierHarvester: IdentifierHarvesting {
    var vendorIdentifier: UUID? {
        if let vendorIdentifier = identifierStorage.loadIdentifier(for: vendorIdentifierKey) {
            return vendorIdentifier
        } else if let vendorIdentifier = legacyVendorIdentifier ?? systemVendorIdentifier {
            identifierStorage.storeIdentifier(vendorIdentifier, for: vendorIdentifierKey)
            return vendorIdentifier
        }

        return nil
    }
}

extension IdentifierHarvester {
    init() {
        self.init(
            identifierStorage: KeychainIdentifierStorage(),
            vendorIdentifierProvider: UIDevice.current
        )
    }

    private var legacyVendorIdentifier: UUID? {
        identifierStorage.loadIdentifier(for: vendorIdentifierLegacyKey)
    }

    private var systemVendorIdentifier: UUID? {
        vendorIdentifierProvider.identifierForVendor
    }
}

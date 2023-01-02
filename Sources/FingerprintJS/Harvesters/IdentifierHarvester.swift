import UIKit

protocol IdentifierHarvesting {
    var vendorIdentifier: UUID? { get }
}

struct IdentifierHarvester {
    private let vendorIdentifierLegacyKey = "vendorIdentifier"
    private let vendorIdentifierKey = "id.vendor"

    private let identifierStorage: IdentifierStorable
    private let device: UIDevice

    init(_ identifierStorage: IdentifierStorable, device: UIDevice) {
        self.identifierStorage = identifierStorage
        self.device = device
    }

    init() {
        self.init(KeychainIdentifierStorage(), device: .current)
    }
}

extension IdentifierHarvester: IdentifierHarvesting {
    var vendorIdentifier: UUID? {
        if let vendorIdentifier = identifierStorage.loadIdentifier(for: vendorIdentifierKey) {
            return vendorIdentifier
        } else {
            guard let vendorIdentifier = legacyVendorIdentifier ?? device.identifierForVendor else {
                return nil
            }

            identifierStorage.storeIdentifier(vendorIdentifier, for: vendorIdentifierKey)
            return vendorIdentifier
        }
    }

    private var legacyVendorIdentifier: UUID? {
        identifierStorage.loadIdentifier(for: vendorIdentifierLegacyKey)
    }
}

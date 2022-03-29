//
//  IdentifierHarvester.swift
//  FingerprintJS
//
//  Created by Petr Palata on 09.03.2022.
//

import Foundation
import UIKit

protocol IdentifierHarvesting {
    var vendorIdentifier: UUID? { get }
}

class IdentifierHarvester {
    private let vendorIdentifierKey = "vendorIdentifier"
    private let identifierStorage: IdentifierStorable
    private let device: UIDevice

    init(_ identifierStorage: IdentifierStorable, device: UIDevice) {
        self.identifierStorage = identifierStorage
        self.device = device
    }

    convenience init() {
        self.init(KeychainIdentifierStorage(), device: UIDevice.current)
    }
}

extension IdentifierHarvester: IdentifierHarvesting {
    var vendorIdentifier: UUID? {
        if let vendorIdentifier = identifierStorage.loadIdentifier(for: vendorIdentifierKey) {
            return vendorIdentifier
        } else {
            guard let vendorIdentifier = device.identifierForVendor else {
                return nil
            }

            identifierStorage.storeIdentifier(vendorIdentifier, for: vendorIdentifierKey)
            return vendorIdentifier
        }
    }
}

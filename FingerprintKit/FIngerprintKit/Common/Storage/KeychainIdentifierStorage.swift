//
//  KeychainIdentifierStorage.swift
//  FingerprintKit
//
//  Created by Petr Palata on 09.03.2022.
//

import Foundation

class KeychainIdentifierStorage: IdentifierStorable {
    var storedIdentifier: UUID? = nil
    
    func storeIdentifier(_ identifier: UUID, for key: String) {
        storedIdentifier = identifier
    }
    
    func loadIdentifier(for key: String) -> UUID? {
        return storedIdentifier
    }
}

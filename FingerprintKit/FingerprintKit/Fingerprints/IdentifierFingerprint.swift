//
//  IdentifierFingerprint.swift
//  FingerprintKit
//
//  Created by Petr Palata on 09.03.2022.
//

import Foundation

public class IdentifierFingerprint {
    private let identifiers: IdentifierHarvesting
    
    public convenience init() {
        self.init(IdentifierHarvester())
    }
    
    init(_ identifiers: IdentifierHarvesting) {
        self.identifiers = identifiers
    }
}

extension IdentifierFingerprint: Fingerprintable {
    public func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        return hashingFunction.fingerprint(data: fingerprintInput)
    }
    
    public var fingerprintInput: Data {
        return identifiers.vendorIdentifier?.uuidString.data(using: .utf8) ?? Data()
    }
}

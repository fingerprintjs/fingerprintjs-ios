//
//  SHA256FingerprintFunction.swift
//  FingerprintKit
//
//  Created by Petr Palata on 10.03.2022.
//

import Foundation
import CryptoKit

public class SHA256HashingFunction: FingerprintFunction {
    public init() {}
    
    public func fingerprint(data: Data) -> String {
        let digest = SHA256.hash(data: data)
        return digest.hexStr
    }
}


//
//  SHA256FingerprintFunction.swift
//  FingerprintKit
//
//  Created by Petr Palata on 10.03.2022.
//

import CryptoKit
import Foundation

class SHA256HashingFunction: FingerprintFunction {
    public func fingerprint(data: Data) -> String {
        let digest = SHA256.hash(data: data)
        return digest.hexStr
    }
}

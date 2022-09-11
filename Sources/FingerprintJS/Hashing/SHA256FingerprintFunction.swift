//
//  SHA256FingerprintFunction.swift
//  FingerprintJS
//
//  Created by Petr Palata on 10.03.2022.
//

import CommonCrypto
import CryptoKit
import Foundation

class SHA256HashingFunction: FingerprintFunction {
    public func fingerprint(data: Data) -> String {
        if #available(iOS 13, tvOS 13, *) {
            let digest = SHA256.hash(data: data)
            return digest.hexStr
        } else {
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
            }
            let digest = Data(hash)
            return digest.map {
                String(format: "%02hhx", $0)
            }.joined()
        }
    }
}

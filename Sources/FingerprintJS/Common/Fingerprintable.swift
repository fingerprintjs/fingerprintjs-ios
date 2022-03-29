//
//  Fingerprintable.swift
//  FingerprintJS
//
//  Created by Petr Palata on 08.03.2022.
//

import CryptoKit
import Foundation

protocol Fingerprintable {
    /// Provides necessary data to compute a fingerprint through a `FingerprintFunction`
    var fingerprintInput: Data { get }

    /// Computes a fingerprint with a `FingerprintFunction` function.
    /// - Returns: Fingerprint in its `String` representation.
    func fingerprint(using hashingFunction: FingerprintFunction) -> String
}

extension DeviceInfoItem: Fingerprintable {
    var fingerprintInput: Data {
        if case .info(let infoValue) = value,
            let data = infoValue.data(using: .ascii)
        {
            return data
        }
        return Data()
    }

    func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        hashingFunction.fingerprint(data: fingerprintInput)
    }
}

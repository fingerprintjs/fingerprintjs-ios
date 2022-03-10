//
//  Fingerprintable.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation
import CryptoKit

public protocol Fingerprintable {
    /// Provides necessary data to compute a fingerprint through a `FingerprintFunction`
    var fingerprintInput: Data { get }
    
    /// Computes a fingerprint with a `FingerprintFunction` function.
    /// - Returns: Fingerprint in its `String` representation.
    func fingerprint(using hashingFunction: FingerprintFunction) -> String
}

public protocol FingerprintFunction {
    func fingerprint(data: Data) -> String
}

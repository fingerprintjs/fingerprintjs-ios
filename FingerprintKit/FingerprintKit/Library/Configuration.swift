//
//  Configuration.swift
//  FingerprintKit
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

/// Enumeration of available FingerprintKit versions
public enum FingerprintKitVersion {
    case v1
}

/// Enumeration of available fingerprinting algorithms
public enum FingerprintAlgorithm {
    /// Default fingerprinting function that uses the SHA256 algorithm to compute the fingerprint
    case sha256

    /// Used for purposes where the library user wants to use their own `FingerprintFunction` algorithm
    case custom(FingerprintFunction)

}

/// `FingerprintKit`'s configuration
public struct Configuration {
    let version: FingerprintKitVersion
    let algorithm: FingerprintAlgorithm

    public init(version: FingerprintKitVersion = .v1, algorithm: FingerprintAlgorithm = .sha256) {
        self.version = version
        self.algorithm = algorithm
    }

    var hashFunction: FingerprintFunction {
        switch algorithm {
        case .sha256:
            return SHA256HashingFunction()
        case .custom(let fingerprintFunction):
            return fingerprintFunction
        }
    }
}

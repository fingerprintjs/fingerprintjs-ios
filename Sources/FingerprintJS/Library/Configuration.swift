//
//  Configuration.swift
//  FingerprintJS
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

/// Enumeration of available FingerprintJS versions
public enum FingerprintJSVersion {
    case v1
}

/// Enumeration of available fingerprinting algorithms
public enum FingerprintAlgorithm {
    /// Default fingerprinting function that uses the SHA256 algorithm to compute the fingerprint
    case sha256

    /// Used for purposes where the library user wants to use their own `FingerprintFunction` algorithm
    case custom(FingerprintFunction)

}

/// `FingerprintJS`'s configuration
public struct Configuration {
    let version: FingerprintJSVersion
    let algorithm: FingerprintAlgorithm

    public init(version: FingerprintJSVersion = .v1, algorithm: FingerprintAlgorithm = .sha256) {
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

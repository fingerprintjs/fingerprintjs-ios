//
//  FingerprinterConfiguration.swift
//  FingerprintKit
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

public enum FingerprintKitVersion {
    case v1
}

public enum FingerprintAlgorithm {
    case sha256
    case custom(FingerprintFunction)
    
}

public struct Configuration {
    private let version: FingerprintKitVersion
    private let algorithm: FingerprintAlgorithm
    
    public init(version: FingerprintKitVersion = .v1, algorithm: FingerprintAlgorithm = .sha256) {
        self.version = version
        self.algorithm = algorithm
    }
}

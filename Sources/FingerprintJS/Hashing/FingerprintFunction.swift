//
//  FingerprintFunction.swift
//  FingerprintJS
//
//  Created by Petr Palata on 20.03.2022.
//

import Foundation

/// An interface represeting hashing algorithm that is used to compute a `String` fingerprint from `Data`
public protocol FingerprintFunction {
    /// Computes fingerprint from the given data
    /// - Parameter data: Input `Data`
    /// - Returns: Fingerprint computed from the input data in its `String` form
    func fingerprint(data: Data) -> String
}

//
//  FingerprintTree.swift
//  FingerprintJS
//
//  Created by Petr Palata on 20.03.2022.
//

import Foundation

/// Entity representing the entire tree/set of device information along with its computed fingerprints
public struct FingerprintTree {
    /// Item representing the information about the current node (either category details or info item)
    public let info: DeviceInfoItem
    /// Optional list of child nodes, each representing either a fingerprinted category or fingerprinted info item
    public let children: [FingerprintTree]?

    let fingerprintData: Data

    /// Computed fingerprint for the current node in its `String` form
    public var fingerprint: String {
        return String.from(fingerprintData)
    }
}

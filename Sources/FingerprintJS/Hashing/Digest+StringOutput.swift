//
//  Digest+StringOutput.swift
//  FingerprintJS
//
//  Created by Petr Palata on 10.03.2022.
//

import CryptoKit
import Foundation

@available(iOS 13.0, tvOS 13.0, *)
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02x", $0) }.joined()
    }
}

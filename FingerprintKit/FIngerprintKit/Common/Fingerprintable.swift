//
//  Fingerprintable.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

public protocol Fingerprintable {
    associatedtype Value
    
    var value: Value { get }
    var hash: String { get }
}

public extension Fingerprintable where Value: Hashable {
    var hash: String {
        return String(value.hashValue)
    }
}

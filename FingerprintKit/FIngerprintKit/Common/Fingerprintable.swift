//
//  Fingerprintable.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

protocol Fingerprintable {
    associatedtype Value
    
    var value: Value { get }
    var hash: String { get }
}

extension Fingerprintable where Value: Hashable {
    var hash: String {
        return String(value.hashValue)
    }
}

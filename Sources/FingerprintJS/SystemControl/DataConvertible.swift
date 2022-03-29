//
//  DataConvertible.swift
//  FingerprintJS
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

protocol DataConvertible {
    static func from(_ data: Data) -> Self
}

extension String: DataConvertible {
    static func from(_ data: Data) -> String {
        return String(data: data, encoding: .ascii) ?? "Undefined"
    }
}

extension Int32: DataConvertible {
    static func from(_ data: Data) -> Int32 {
        return data.withUnsafeBytes { ptr in
            return ptr.load(as: Int32.self)
        }
    }
}

extension Int64: DataConvertible {
    static func from(_ data: Data) -> Int64 {
        return data.withUnsafeBytes { ptr in
            return ptr.load(as: Int64.self)
        }
    }
}

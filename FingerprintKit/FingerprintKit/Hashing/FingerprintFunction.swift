//
//  FingerprintFunction.swift
//  FingerprintKit
//
//  Created by Petr Palata on 20.03.2022.
//

import Foundation

public protocol FingerprintFunction {
    func fingerprint(data: Data) -> String
}


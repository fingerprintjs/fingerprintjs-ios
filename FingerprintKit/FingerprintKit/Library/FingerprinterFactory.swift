//
//  FingerprinterFactory.swift
//  FingerprintKit
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

public protocol FingerprinterInstanceProviding {
    static func getInstance(_ configuration: Configuration) -> Fingerprinter
}

public class FingerprinterFactory: FingerprinterInstanceProviding {
    public static func getInstance(_ configuration: Configuration = Configuration()) -> Fingerprinter {
        return Fingerprinter(configuration)
    }
}


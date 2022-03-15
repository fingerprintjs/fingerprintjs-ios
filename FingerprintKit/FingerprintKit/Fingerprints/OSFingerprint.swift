//
//  OSFingerprint.swift
//  FingerprintKit
//
//  Created by Petr Palata on 15.03.2022.
//

import Foundation

class OSFingerprint: Fingerprintable {
    private let osInfo = OSInfoHarvester()
    
    var fingerprintInput: Data {
        let strings = [
            osInfo.osType,
            osInfo.osBuild,
            osInfo.osRelease,
            osInfo.osVersion,
            osInfo.kernelVersion
        ]
        
        return strings.compactMap{$0}.joined(separator: "/").data(using: .utf8) ?? Data()
    }
    
    func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        return hashingFunction.fingerprint(data: fingerprintInput)
    }
}

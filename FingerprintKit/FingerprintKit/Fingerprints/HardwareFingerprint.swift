//
//  HardwareSignals.swift
//  FingerprintKit
//
//  Created by Petr Palata on 07.03.2022.
//

import Foundation
import UIKit
import CryptoKit

public class HardwareFingerprint {
    let hardwareInfo: HardwareInfoHarvesting
    
    init(_ hardwareInfo: HardwareInfoHarvesting) {
        self.hardwareInfo = hardwareInfo
    }
    
    public convenience init() {
        self.init(HardwareInfoHarvester())
    }
}

extension HardwareFingerprint: Fingerprintable {
    public func fingerprint(using hashingFunction: FingerprintFunction = SHA256HashingFunction()) -> String {
        return hashingFunction.fingerprint(data: fingerprintInput)
    }
    
    public var fingerprintInput: Data {
        let strings = [
            hardwareInfo.deviceModel,
            hardwareInfo.deviceType,
            hardwareInfo.displayResolution.description,
        ]
        
        return strings.compactMap{$0}.joined(separator: "/").data(using: .utf8) ?? Data()
    }
}


extension String: Error {}

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "\(self.width)x\(self.height)"
    }
}

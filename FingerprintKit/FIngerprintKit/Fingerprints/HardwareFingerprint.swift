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
        let deviceModel = hardwareInfo.deviceModel
        let deviceType = hardwareInfo.deviceType
        let deviceResolution = hardwareInfo.displayResolution
        
        let combinedString = deviceModel + deviceType + "\(deviceResolution.width)x\(deviceResolution.height)"
        guard let data = combinedString.data(using: .utf8) else {
            return ""
        }
        return hashingFunction.fingerprint(data: data)
    }
    
    public var fingerprintInput: Data {
        let strings = [
            hardwareInfo.deviceModel,
            hardwareInfo.deviceType,
            hardwareInfo.displayResolution.description,
        ]
        
        return strings.joined(separator: "/").data(using: .utf8) ?? Data()
    }
}


extension String: Error {}

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "\(self.width)x\(self.height)"
    }
}

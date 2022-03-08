//
//  HardwareSignals.swift
//  FingerprintKit
//
//  Created by Petr Palata on 07.03.2022.
//

import Foundation
import UIKit

public class HardwareSignals {
    let device: UIDevice
    
    public init(_ device: UIDevice) {
        self.device = device
    }

    var deviceModel: String {
        return device.model
    }
    
    var vendorIdentifier: String? {
        guard let vendorIdentifier = device.identifierForVendor else {
            return nil
        }
        
        return vendorIdentifier.uuidString
    }
    
    public var deviceModelSignal: DeviceModelSignal {
        return DeviceModelSignal(value: device.model)
    }
    
    public var deviceIdentifierSignal: DeviceIdentifierSignal? {
        guard let deviceIdentifier = vendorIdentifier else {
            return nil
        }
        
        return DeviceIdentifierSignal(value: deviceIdentifier)
    }
}

public struct DeviceModelSignal: Fingerprintable {
    public var value: String
}

public struct DeviceIdentifierSignal: Fingerprintable {
    public var value: String
}

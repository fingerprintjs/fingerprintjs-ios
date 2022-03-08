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
    
    public var deviceModelSignal: DeviceModelSignal {
        return DeviceModelSignal(value: device.model)
    }
}

public struct DeviceModelSignal: Fingerprintable {
    public var value: String
}

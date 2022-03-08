//
//  HardwareSignals.swift
//  FingerprintKit
//
//  Created by Petr Palata on 07.03.2022.
//

import Foundation
import UIKit

class HardwareSignals {
    let device: UIDevice
    
    init(_ device: UIDevice) {
        self.device = device
    }
    
    var deviceModel: String {
        return device.model
    }
    
    var deviceModelSignal: DeviceModelSignal {
        return DeviceModelSignal(value: device.model)
    }
}

struct DeviceModelSignal: Fingerprintable {
    var value: String
}

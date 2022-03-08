//
//  HardwareInfoHarvester.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation
import UIKit

public protocol HardwareInfoHarvesting {
    /// Returns high-level device type (e.g. iPhone)
    var deviceType: String { get }
    
    /// Returns physical resolution (in pixels) for the current device
    var displayResolution: CGSize { get }
    
    /// Returns device model identifier (e.g. iPhone 13,3)
    var deviceModel: String { get }
}

public class HardwareInfoHarvester {
    private let device: UIDevice
    private let screen: UIScreen
    private let systemControl: SystemControl
    
    init(_ device: UIDevice, screen: UIScreen, systemControl: SystemControl) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
    }
    
    public convenience init() {
        self.init( UIDevice.current, screen: UIScreen.main, systemControl: SystemControl())
    }
}

extension HardwareInfoHarvester: HardwareInfoHarvesting {
    public var deviceType: String {
        return device.model
    }
    
    public var displayResolution: CGSize {
        let nativeBounds = screen.nativeBounds
        return CGSize(width: nativeBounds.width, height: nativeBounds.height)
    }
    
    public var deviceModel: String {
        return systemControl.hardwareModel ?? "Undefined"
    }
}

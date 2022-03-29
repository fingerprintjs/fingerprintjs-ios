//
//  HardwareInfoHarvester.swift
//  FingerprintJS
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation
import UIKit

protocol HardwareInfoHarvesting {
    /// Returns high-level device type (e.g. iPhone)
    var deviceType: String { get }

    /// Returns physical resolution (in pixels) for the current device
    var displayResolution: CGSize { get }

    /// Returns device model identifier (e.g. iPhone 13,3)
    var deviceModel: String { get }
}

class HardwareInfoHarvester {
    private let device: UIDevice
    private let screen: UIScreen
    private let systemControl: SystemControl

    init(_ device: UIDevice, screen: UIScreen, systemControl: SystemControl) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
    }

    public convenience init() {
        self.init(UIDevice.current, screen: UIScreen.main, systemControl: SystemControl())
    }
}

extension HardwareInfoHarvester: HardwareInfoHarvesting {
    var deviceType: String {
        return device.model
    }

    var displayResolution: CGSize {
        let nativeBounds = screen.nativeBounds
        return CGSize(width: nativeBounds.width, height: nativeBounds.height)
    }

    var deviceModel: String {
        return systemControl.hardwareModel ?? "Undefined"
    }

    var memorySize: String {
        guard let memorySize = systemControl.memorySize else {
            return "Undefined"
        }
        return "\(memorySize)"
    }

    var physicalMemory: String {
        guard let physicalMemory = systemControl.physicalMemory else {
            return "Undefined"
        }
        return "\(physicalMemory)"
    }

    var cpuCount: String {
        return "\(ProcessInfo.processInfo.processorCount)"
    }

    var cpuFrequency: String {
        guard let cpuFrequency = systemControl.cpuFrequency else {
            return "Undefined"
        }
        return "\(cpuFrequency)"
    }
}

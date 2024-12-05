import UIKit

#if !COCOAPODS
import SystemControl
#endif

protocol HardwareInfoHarvesting {
    /// The user-assigned device name.
    var deviceName: String { get }

    /// High-level device type (e.g. iPhone).
    var deviceType: String { get }

    /// Device model identifier (e.g. iPhone 13,3).
    var deviceModel: String { get }

    /// Physical resolution (in pixels) for the current device
    var displayResolution: CGSize { get }

    /// The native scale factor for the display.
    var displayScale: CGFloat { get }

    /// Number of physical CPU cores
    var cpuCount: String { get }

    /// Memory (RAM) size in bytes
    var memorySize: String { get }

    /// Kernel hostname obtained through sysctl API
    var kernelHostname: String { get }
}

struct HardwareInfoHarvester {
    private let device: DeviceIdentificationInfoProviding
    private let screen: ScreenInfoProviding
    private let systemControl: SystemControlValuesProviding
    private let processInfo: CPUInfoProviding

    init(
        device: DeviceIdentificationInfoProviding,
        screen: ScreenInfoProviding,
        systemControl: SystemControlValuesProviding,
        processInfo: CPUInfoProviding
    ) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
        self.processInfo = processInfo
    }

    init() {
        self.init(
            device: UIDevice.current,
            screen: UIScreen.main,
            systemControl: SystemControlValuesProvider(),
            processInfo: ProcessInfo.processInfo
        )
    }
}

extension HardwareInfoHarvester: HardwareInfoHarvesting {
    var deviceName: String {
        device.userAssignedName
    }

    var deviceType: String {
        device.model
    }

    var deviceModel: String {
        systemControl.hardwareModel ?? "Undefined"
    }

    var displayResolution: CGSize {
        let nativeBounds = screen.nativeBounds
        return CGSize(width: nativeBounds.width, height: nativeBounds.height)
    }

    var displayScale: CGFloat {
        screen.nativeScale
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
        return "\(processInfo.processorCount)"
    }

    var cpuFrequency: String {
        guard let cpuFrequency = systemControl.cpuFrequency else {
            return "Undefined"
        }
        return "\(cpuFrequency)"
    }

    var kernelHostname: String {
        systemControl.hostname ?? "Undefined"
    }
}

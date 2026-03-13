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

    /// Battery charge level
    var batteryLevel: Float? { get }

    /// Whether Low Power Mode is enabled
    var isLowPowerModeEnabled: Bool { get }
}

struct HardwareInfoHarvester {
    private let device: DeviceIdentificationInfoProviding
    private let screen: ScreenInfoProviding
    private let systemControl: SystemControlValuesProviding
    private let processInfo: CPUInfoProviding
    private let lowPowerMode: LowPowerModeProviding
    #if os(iOS)
    private let battery: BatteryLevelProviding

    init(
        device: DeviceIdentificationInfoProviding,
        screen: ScreenInfoProviding,
        systemControl: SystemControlValuesProviding,
        processInfo: CPUInfoProviding,
        battery: BatteryLevelProviding,
        lowPowerMode: LowPowerModeProviding
    ) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
        self.processInfo = processInfo
        self.battery = battery
        self.lowPowerMode = lowPowerMode
    }

    init() {
        self.init(
            device: UIDevice.current,
            screen: UIScreen.main,
            systemControl: SystemControlValuesProvider(),
            processInfo: ProcessInfo.processInfo,
            battery: UIDevice.current,
            lowPowerMode: ProcessInfo.processInfo
        )
    }
    #else
    init(
        device: DeviceIdentificationInfoProviding,
        screen: ScreenInfoProviding,
        systemControl: SystemControlValuesProviding,
        processInfo: CPUInfoProviding,
        lowPowerMode: LowPowerModeProviding
    ) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
        self.processInfo = processInfo
        self.lowPowerMode = lowPowerMode
    }

    init() {
        self.init(
            device: UIDevice.current,
            screen: UIScreen.main,
            systemControl: SystemControlValuesProvider(),
            processInfo: ProcessInfo.processInfo,
            lowPowerMode: ProcessInfo.processInfo
        )
    }
    #endif
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

    var batteryLevel: Float? {
        let batteryLevel: Float
        #if os(iOS)
        let isBatteryMonitoringEnabled = battery.isBatteryMonitoringEnabled
        battery.isBatteryMonitoringEnabled = true
        batteryLevel = battery.batteryLevel
        battery.isBatteryMonitoringEnabled = isBatteryMonitoringEnabled
        #else
        batteryLevel = -1
        #endif
        return batteryLevel >= 0 ? batteryLevel : nil
    }

    var isLowPowerModeEnabled: Bool {
        lowPowerMode.isLowPowerModeEnabled
    }
}

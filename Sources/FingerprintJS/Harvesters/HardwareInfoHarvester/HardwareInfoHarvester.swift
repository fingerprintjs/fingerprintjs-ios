import SystemControl
import UIKit

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

    /// Free disk space on the device or 0 if a permission problem occurs
    var freeDiskSpace: UInt64 { get }

    /// Total disk space on the device or 0 if a permission problem occurs
    var totalDiskSpace: UInt64 { get }

    /// Disk space information (free and total)
    var diskSpaceInfo: DiskSpaceInfo? { get }

    /// Number of physical CPU cores
    var cpuCount: String { get }

    /// Memory (RAM) size in bytes
    var memorySize: String { get }
}

struct HardwareInfoHarvester {
    private let device: DeviceIdentificationInfoProviding
    private let screen: ScreenInfoProviding
    private let systemControl: SystemControlValuesProviding
    private let fileManager: DocumentsDirectoryAttributesProviding
    private let processInfo: CPUInfoProviding

    init(
        device: DeviceIdentificationInfoProviding,
        screen: ScreenInfoProviding,
        systemControl: SystemControlValuesProviding,
        fileManager: DocumentsDirectoryAttributesProviding,
        processInfo: CPUInfoProviding
    ) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
        self.fileManager = fileManager
        self.processInfo = processInfo
    }

    init() {
        self.init(
            device: UIDevice.current,
            screen: UIScreen.main,
            systemControl: SystemControlValuesProvider(),
            fileManager: FileManager.default,
            processInfo: ProcessInfo.processInfo
        )
    }

    var diskSpaceInfo: DiskSpaceInfo? {
        do {
            let dict = try fileManager.documentsDirectoryAttributes()
            if let fileSystemSizeInBytes = dict[.systemSize] as? UInt64,
                let fileSystemFreeSizeInBytes = dict[.systemFreeSize] as? UInt64
            {
                return DiskSpaceInfo(
                    freeDiskSpace: fileSystemFreeSizeInBytes,
                    totalDiskSpace: fileSystemSizeInBytes
                )
            }
        } catch {
            print("Failed to obtain disk space info: \(error)")
        }

        return nil
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

    var freeDiskSpace: UInt64 {
        return diskSpaceInfo?.freeDiskSpace ?? 0
    }

    var totalDiskSpace: UInt64 {
        return diskSpaceInfo?.totalDiskSpace ?? 0
    }
}

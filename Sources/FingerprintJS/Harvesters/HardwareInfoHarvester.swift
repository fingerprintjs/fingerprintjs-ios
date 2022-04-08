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

    /// Returns free disk space on the device or 0 if a permission problem occurs
    var freeDiskSpace: UInt64 { get }

    /// Returns total disk space on the device or 0 if a permission problem occurs
    var totalDiskSpace: UInt64 { get }
}

class HardwareInfoHarvester {
    private let device: UIDevice
    private let screen: UIScreen
    private let systemControl: SystemControlValuesProviding
    private let fileManager: DocumentsDirectoryAttributesProviding
    private let processInfo: ProcessInfo

    init(
        _ device: UIDevice,
        screen: UIScreen,
        systemControl: SystemControlValuesProviding,
        fileManager: DocumentsDirectoryAttributesProviding,
        processInfo: ProcessInfo
    ) {
        self.device = device
        self.screen = screen
        self.systemControl = systemControl
        self.fileManager = fileManager
        self.processInfo = processInfo
    }

    convenience init() {
        self.init(
            UIDevice.current,
            screen: UIScreen.main,
            systemControl: SystemControl(),
            fileManager: FileManager.default,
            processInfo: ProcessInfo.processInfo
        )
    }

    private var diskSpaceInfo: DiskSpaceInfo? {
        do {
            let dict = try fileManager.documentsDirectoryAttributes()
            if let fileSystemSizeInBytes = dict[FileAttributeKey.systemSize] as? UInt64,
                let fileSystemFreeSizeInBytes = dict[FileAttributeKey.systemFreeSize] as? UInt64
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

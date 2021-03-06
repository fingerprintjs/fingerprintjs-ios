//
//  DeviceInfoProvider.swift
//  FingerprintJS
//
//  Created by Petr Palata on 19.04.2022.
//

import Foundation

public protocol DeviceInfoProviding {
    /// Gathers and returns all information about the device
    /// - Returns: `DeviceInfo` object that contains typed representation of device information values
    func getDeviceInfo() async -> DeviceInfo
    
    /// Gathers all information about the device and reports it through the completion block
    /// - Parameter completion: Completion block reporting the `DeviceInfo` object
    func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void)
}

public class DeviceInfoProvider {
    let hardwareInfoHarvester: HardwareInfoHarvesting
    let osInfoHarvester: OSInfoHarvesting
    let identifierHarvester: IdentifierHarvesting

    public convenience init() {
        self.init(
            IdentifierHarvester(),
            hardwareInfoHarvester: HardwareInfoHarvester(),
            osInfoHarvester: OSInfoHarvester()
        )
    }

    init(
        _ identifierHarvester: IdentifierHarvesting,
        hardwareInfoHarvester: HardwareInfoHarvesting,
        osInfoHarvester: OSInfoHarvesting
    ) {
        self.identifierHarvester = identifierHarvester
        self.hardwareInfoHarvester = hardwareInfoHarvester
        self.osInfoHarvester = osInfoHarvester
    }
}

extension DeviceInfoProvider: DeviceInfoProviding {

    public func getDeviceInfo() async -> DeviceInfo {
        return DeviceInfo(
            vendorIdentifier: identifierHarvester.vendorIdentifier,
            diskSpace: hardwareInfoHarvester.diskSpaceInfo,
            screenResolution: hardwareInfoHarvester.displayResolution,
            deviceType: hardwareInfoHarvester.deviceType,
            deviceModel: hardwareInfoHarvester.deviceModel,
            memorySize: hardwareInfoHarvester.memorySize,
            physicalMemory: hardwareInfoHarvester.memorySize,
            cpuCount: hardwareInfoHarvester.cpuCount,
            osBuild: osInfoHarvester.osBuild,
            osVersion: osInfoHarvester.osVersion,
            osType: osInfoHarvester.osType,
            osRelease: osInfoHarvester.osRelease,
            kernelVersion: osInfoHarvester.kernelVersion
        )
    }

    public func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void) {
        Task.init {
            let deviceInfo = await getDeviceInfo()
            completion(deviceInfo)
        }
    }
}

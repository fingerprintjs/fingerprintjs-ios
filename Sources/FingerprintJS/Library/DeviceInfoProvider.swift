//
//  DeviceInfoProvider.swift
//  FingerprintJS
//
//  Created by Petr Palata on 19.04.2022.
//

import Foundation

public protocol DeviceInfoProviding {
    func getDeviceInfo() async -> DeviceInfo
    func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void)
}

public class DeviceInfoProvider {
    let hardwareInfoHarvester: HardwareInfoHarvesting = HardwareInfoHarvester()
    let osInfoHarvester: OSInfoHarvesting = OSInfoHarvester()
    let identifierHarvester: IdentifierHarvesting = IdentifierHarvester()

    public init() {}
}

extension DeviceInfoProvider: DeviceInfoProviding {

    public func getDeviceInfo() async -> DeviceInfo {
        return DeviceInfo(
            vendorIdentifier: identifierHarvester.vendorIdentifier, diskSpace: hardwareInfoHarvester.diskSpaceInfo,
            screenResolution: hardwareInfoHarvester.displayResolution, deviceType: hardwareInfoHarvester.deviceType,
            deviceModel: hardwareInfoHarvester.deviceModel, memorySize: nil,
            physicalMemory: hardwareInfoHarvester.memorySize, cpuCount: hardwareInfoHarvester.cpuCount,
            osBuild: nil, osVersion: nil, osType: nil, osRelease: nil, kernelVersion: nil)
    }

    public func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void) {
        Task.init {
            let deviceInfo = await getDeviceInfo()
            completion(deviceInfo)
        }
    }
}

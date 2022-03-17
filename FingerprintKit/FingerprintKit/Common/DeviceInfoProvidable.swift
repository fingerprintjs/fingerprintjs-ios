//
//  DeviceInfoProvidable.swift
//  FingerprintKit
//
//  Created by Petr Palata on 13.03.2022.
//

import Foundation

public protocol DeviceInfoProvidable {
    func getDeviceInfo() -> [DeviceInfoCategory]
}

public struct DeviceInfoItem {
    public let label: String
    public let value: String
    public let fingerprint: String?
    public let children: [DeviceInfoItem]?
}

extension DeviceInfoItem: CustomStringConvertible {
    public var description: String {
        let base = "\(label): \(value)"
        var childrenDebug = ""
        if let children = children {
            childrenDebug += "\n"
            childrenDebug += """
                                 Children [
                                    \(children.map { $0.description }.joined(separator: "\n"))
                                 ]
                             """
        }
        
        return base + childrenDebug
    }
}


public struct DeviceInfoCategory {
    public let fingerprint: String?
    public let label: String
    public let items: [DeviceInfoItem]
    
    init(label: String, items: [DeviceInfoItem], fingerprint: String? = nil) {
        self.label = label
        self.items = items
        self.fingerprint = fingerprint
    }
}

/*
extension HardwareInfoHarvester: DeviceInfoProvidable {
    public func getDeviceInfo() -> [DeviceInfoCategory] {
        return [DeviceInfoCategory(label: "Hardware information", items: [
            DeviceInfoItem(label: "Device type", value: deviceType),
            DeviceInfoItem(label: "Device model", value: deviceModel),
            DeviceInfoItem(label: "Display resolution", value: self.displayResolution.description),
            DeviceInfoItem(label: "Physical memory", value: memorySize),
            DeviceInfoItem(label: "Processor count", value: cpuCount),
            DeviceInfoItem(label: "Physical memory 2", value: physicalMemory),
            DeviceInfoItem(label: "CPU frequency", value: cpuFrequency),
        ], fingerprint: HardwareFingerprint().fingerprint())]
    }
}

extension OSInfoHarvester: DeviceInfoProvidable {
    public func getDeviceInfo() -> [DeviceInfoCategory] {
        return [DeviceInfoCategory(label: "OS Information", items: [
            DeviceInfoItem(label: "OS build", value: osBuild),
            DeviceInfoItem(label: "OS release", value: osRelease),
            DeviceInfoItem(label: "OS type", value: osType),
            DeviceInfoItem(label: "OS version", value: osVersion),
            DeviceInfoItem(label: "Kernel version", value: kernelVersion),
        ], fingerprint: OSFingerprint().fingerprint(using: SHA256HashingFunction()))]
    }
}

extension IdentifierHarvester: DeviceInfoProvidable {
    public func getDeviceInfo() -> [DeviceInfoCategory] {
        return [DeviceInfoCategory(label: "Identifier Information", items: [
            DeviceInfoItem(label: "Vendor ID", value: vendorIdentifier?.description ?? "Undefined")
        ])]
    }
}
*/

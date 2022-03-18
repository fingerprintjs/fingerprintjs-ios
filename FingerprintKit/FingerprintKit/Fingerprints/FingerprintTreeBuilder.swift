//
//  FingerprintTreeBuilder.swift
//  FingerprintKit
//
//  Created by Petr Palata on 17.03.2022.
//

import Foundation

protocol DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem
}

class FingerprintTreeBuilder: DeviceInfoTreeProvider {
    let treeProviders: [DeviceInfoTreeProvider] = [
        HardwareInfoHarvester(),
        OSInfoHarvester(),
        IdentifierHarvester()
    ]
    
    public init() {}
    
    public func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        let children = treeProviders.map { provider in
            return provider.buildTree(configuration)
        }
        
        return DeviceInfoItem(
            label: "Device Fingerprint",
            value: .category,
            children: children
        )
    }
}


extension HardwareInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Hardware",
            value: .category,
            children: [
                DeviceInfoItem(label: "Device type", value: .info(deviceType)),
                DeviceInfoItem(label: "Device model", value: .info(deviceModel)),
                DeviceInfoItem(label: "Display resolution", value: .info(self.displayResolution.description)),
                DeviceInfoItem(label: "Physical memory", value: .info(memorySize)),
                DeviceInfoItem(label: "Processor count", value: .info(cpuCount)),
                DeviceInfoItem(label: "Physical memory 2", value: .info(physicalMemory)),
                DeviceInfoItem(label: "CPU frequency", value: .info(cpuFrequency))
            ]
        )
    }
}

extension IdentifierHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Identifiers",
            value: .category,
            children: [
                DeviceInfoItem(
                    label: "Vendor identifier",
                    value: .info(vendorIdentifier?.uuidString ?? "No identifier")
                )
            ]
        )
    }
}

extension OSInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Operating System",
            value: .category,
            children: [
                DeviceInfoItem(label: "OS build", value: .info(osBuild)),
                DeviceInfoItem(label: "OS release", value: .info(osRelease)),
                DeviceInfoItem(label: "OS type", value: .info(osType)),
                DeviceInfoItem(label: "OS version", value: .info(osVersion)),
                DeviceInfoItem(label: "Kernel version", value: .info(kernelVersion))
            ]
        )
    }
}

class TreeFingerprintCalculator {
    func calculateFingerprints(from tree: DeviceInfoItem, hashFunction: FingerprintFunction) -> FingerprintTree {
        if let children = tree.children {
            let fingerprintedChildren = children.map {
                calculateFingerprints(from: $0, hashFunction: hashFunction)
            }
            
            let childrenFingeprintData = fingerprintedChildren.reduce(Data()) { prev, item in
                return prev + item.fingerprintData
            }
            
            let fingerprint = hashFunction.fingerprint(data: childrenFingeprintData)
            return FingerprintTree(
                info: tree,
                children: fingerprintedChildren,
                fingerprintData: fingerprint.data(using: .ascii) ?? Data()
            )
        } else {
            return FingerprintTree(
                info: tree,
                children: nil,
                fingerprintData: tree.fingerprint(using: hashFunction).data(using: .ascii) ?? Data()
            )
        }
    }
}

extension DeviceInfoItem: Fingerprintable {
    public var fingerprintInput: Data {
        if case let .info(infoValue) = value,
           let data = infoValue.data(using: .ascii) {
            return data
        }
        return Data()
    }
    
    public func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        hashingFunction.fingerprint(data: fingerprintInput)
    }
}

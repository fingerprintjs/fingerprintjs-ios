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

public class FingerprintTreeBuilder: DeviceInfoTreeProvider {
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
        return DeviceInfoItem(label: "Fingerprint", value: "Top", fingerprint: nil, children: children)
    }
}


// builds tree of items
// top
// hardwareItem value = .category(hardware), osItem value = .category(operating system) etc...
// hwItem1 value = .leaf()

extension HardwareInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "System Information",
            value: "Category",
            fingerprint: nil,
            children: [
                DeviceInfoItem(label: "Device type", value: deviceType, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "Device model", value: deviceModel, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "Display resolution", value: self.displayResolution.description, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "Physical memory", value: memorySize, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "Processor count", value: cpuCount, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "Physical memory 2", value: physicalMemory, fingerprint: nil, children: nil),
                DeviceInfoItem(label: "CPU frequency", value: cpuFrequency, fingerprint: nil, children: nil),
            ]
        )
    }
}

extension IdentifierHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Identifier Information",
            value: "Category",
            fingerprint: nil,
            children: [
                DeviceInfoItem(
                    label: "Vendor identifier",
                    value: vendorIdentifier?.uuidString ?? "No identifier",
                    fingerprint: nil,
                    children: nil
                )
            ]
        )
    }
}

extension OSInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "System Information",
            value: "Category",
            fingerprint: nil,
            children: [
                DeviceInfoItem(label: "OS", value: osVersion, fingerprint: nil, children: nil),
            ]
        )
    }
}

class TreeFingerprintCalculator {
    func calculateFingerprints(from tree: DeviceInfoItem, hashFunction: FingerprintFunction) -> DeviceInfoItem {
        if let children = tree.children {
            let fingerprintedChildren = children.map { calculateFingerprints(from: $0, hashFunction: hashFunction) }
            let fingerprint = hashFunction.fingerprint(data: fingerprintedChildren.reduce(into: "", { $0 += ($1.fingerprint ?? "") }).data(using: .utf8) ?? Data())
            return DeviceInfoItem(label: tree.label, value: tree.value, fingerprint: fingerprint, children: fingerprintedChildren)
        } else {
            return DeviceInfoItem(label: tree.label, value: tree.value, fingerprint: tree.fingerprint(using: hashFunction), children: tree.children)
        }
    }
}


extension DeviceInfoItem: Fingerprintable {
    public var fingerprintInput: Data {
        return value.data(using: .utf8) ?? Data()
    }
    
    public func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        hashingFunction.fingerprint(data: fingerprintInput)
    }
}

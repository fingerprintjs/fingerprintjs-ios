//
//  FingerprintTreeBuilder.swift
//  FingerprintKit
//
//  Created by Petr Palata on 17.03.2022.
//

import Foundation

class CompoundTreeBuilder {
    private let treeProviders: [DeviceInfoTreeProvider]
    
    convenience init() {
        self.init([
            HardwareInfoHarvester(),
            OSInfoHarvester(),
            IdentifierHarvester()
        ])
    }
    
    init(_ treeProviders: [DeviceInfoTreeProvider]) {
        self.treeProviders = treeProviders
    }
}

extension CompoundTreeBuilder: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
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

//
//  DeviceInfoProvidable.swift
//  FingerprintKit
//
//  Created by Petr Palata on 13.03.2022.
//

import Foundation

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

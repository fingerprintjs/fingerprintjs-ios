//
//  DeviceInfo.swift
//  FingerprintJS
//
//  Created by Petr Palata on 15.04.2022.
//

import CoreGraphics
import Foundation

public struct DeviceInfo {
    public let vendorIdentifier: UUID?

    public let diskSpace: DiskSpaceInfo?
    public let screenResolution: CGSize?
    public let deviceType: String?
    public let deviceModel: String?
    public let memorySize: String?
    public let physicalMemory: String?
    public let cpuCount: String?

    public let osBuild: String?
    public let osVersion: String?
    public let osType: String?
    public let osRelease: String?
    public let kernelVersion: String?
}

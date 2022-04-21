//
//  DeviceInfo.swift
//  FingerprintJS
//
//  Created by Petr Palata on 15.04.2022.
//

import CoreGraphics
import Foundation

public struct DeviceInfo {
    let vendorIdentifier: UUID?

    let diskSpace: DiskSpaceInfo?
    let screenResolution: CGSize?
    let deviceType: String?
    let deviceModel: String?
    let memorySize: String?
    let physicalMemory: String?
    let cpuCount: String?

    let osBuild: String?
    let osVersion: String?
    let osType: String?
    let osRelease: String?
    let kernelVersion: String?

    /*
    init() {
        self.vendorIdentifier = nil

        self.diskSpace = nil
        self.screenResolution = nil
        self.deviceType = nil
        self.deviceModel = nil
        self.memorySize = nil
        self.physicalMemory = nil
        self.cpuCount = nil

        self.osBuild = nil
        self.osVersion = nil
        self.osType = nil
        self.osRelease = nil
        self.kernelVersion = nil
    }
     */
}

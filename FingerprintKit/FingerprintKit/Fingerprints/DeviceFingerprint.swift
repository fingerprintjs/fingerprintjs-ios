//
//  DeviceFingerprint.swift
//  FingerprintKit
//
//  Created by Petr Palata on 10.03.2022.
//

import Foundation

public final class DeviceFingerprint {
    private let hardwareFingerprint: Fingerprintable
    private let identifierFingerprint: Fingerprintable
    
    private convenience init() {
        self.init(HardwareFingerprint(), identifierFingerprint: IdentifierFingerprint())
    }
    
    init(_ hardwareFingerprint: Fingerprintable, identifierFingerprint: Fingerprintable) {
        self.hardwareFingerprint = hardwareFingerprint
        self.identifierFingerprint = identifierFingerprint
    }
    
    
    public static var fingerprint: String {
        let fingerprintKit = DeviceFingerprint()
        return fingerprintKit.fingerprint(using: SHA256HashingFunction())
    }
}

extension DeviceFingerprint: Fingerprintable {
    public func fingerprint(using hashingFunction: FingerprintFunction) -> String {
        return hashingFunction.fingerprint(data: fingerprintInput)
    }
    
    public var fingerprintInput: Data {
        var allData = Data()
        [
            hardwareFingerprint.fingerprintInput,
            identifierFingerprint.fingerprintInput
        ].forEach { data in
            allData.append(data)
        }
        return allData
    }
}

public struct DeviceInfo: DeviceInfoProvidable {
    let hardwareInfo = HardwareInfoHarvester()
    let osInfo = OSInfoHarvester()
    let identifiers = IdentifierHarvester()
    
    public init() {}
    
    public func getDeviceInfo() -> [DeviceInfoCategory] {
        let providers: [DeviceInfoProvidable] = [hardwareInfo, osInfo, identifiers]
        return providers.reduce(into: []) { categories, provider in
            return categories += provider.getDeviceInfo()
        }
    }
}


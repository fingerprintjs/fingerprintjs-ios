//
//  Fingerprinter.swift
//  FingerprintKit
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

public class Fingerprinter {
    private let configuration: Configuration
    private let identifiers: IdentifierHarvesting
    
    public convenience init(_ configuration: Configuration) {
        self.init(configuration, identifiers: IdentifierHarvester())
    }
    
    init(_ configuration: Configuration, identifiers: IdentifierHarvesting) {
        self.configuration = configuration
        self.identifiers = identifiers
    }
    
    public func getDeviceId(_ completion: @escaping (String?) -> Void) {
        completion(self.identifiers.vendorIdentifier?.uuidString)
    }
    
    public func getFingerprint(_ completion: @escaping (String) -> Void) {
        getFingerprintTree { deviceItem in
            completion(deviceItem.fingerprint!)
        }
    }
    
    public func getFingerprintTree(_ completion: @escaping (DeviceInfoItem) -> Void) {
        completion(DeviceInfoItem(label: "label", value: "value", fingerprint: "test", children: nil))
    }
}

@available(iOS 13, macOS 11, *)
public extension Fingerprinter {
    func getDeviceId() async -> String? {
        return await withCheckedContinuation({ continuation in
            self.getDeviceId { deviceId in
                continuation.resume(with: .success(deviceId))
            }
        })
    }
    
    func getFingerprintTree() async -> DeviceInfoItem  {
        return await withCheckedContinuation({ continuation in
            self.getFingerprint { fingerprint in
                continuation.resume(with: .success(
                    DeviceInfoItem(
                        label: "Fingerprint",
                        value: fingerprint,
                        fingerprint: nil,
                        children: nil
                    )
                ))
            }
        })
    }
    
    func getFingerprint() async -> String {
        return await withCheckedContinuation({ continuation in
            self.getFingerprint { fingerprint in
                continuation.resume(with: .success(fingerprint))
            }
        })
    }
}

//
//  OSInfoHarvester.swift
//  FingerprintKit
//
//  Created by Petr Palata on 11.03.2022.
//

public protocol OSInfoHarvesting {
    var osBuild: String { get }
    
    var osVersion: String { get }
    
    var osType: String { get }
    
    var kernelVersion: String { get }
}

public class OSInfoHarvester {
    private let systemControl = SystemControl()
    
    public init() {}
}

extension OSInfoHarvester: OSInfoHarvesting {
    public var osType: String {
        return systemControl.osType ?? "Undefined"
    }
    
    public var osVersion: String {
        return systemControl.osVersion ?? "Undefined"
    }
    
    public var osRelease: String {
        return systemControl.osRelease ?? "Undefined"
    }
    
    public var kernelVersion: String {
        return systemControl.kernelVersion ?? "Undefined"
    }
    
    public var osBuild: String {
        guard let osBuild = systemControl.osBuild else {
            return "Undefined"
        }
        return "\(osBuild)"
    }
}

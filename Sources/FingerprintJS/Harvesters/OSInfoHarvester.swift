//
//  OSInfoHarvester.swift
//  FingerprintJS
//
//  Created by Petr Palata on 11.03.2022.
//

protocol OSInfoHarvesting {
    var osBuild: String { get }

    var osVersion: String { get }

    var osType: String { get }

    var kernelVersion: String { get }
}

class OSInfoHarvester {
    private let systemControl = SystemControl()

    public init() {}
}

extension OSInfoHarvester: OSInfoHarvesting {
    var osType: String {
        return systemControl.osType ?? "Undefined"
    }

    var osVersion: String {
        return systemControl.osVersion ?? "Undefined"
    }

    var osRelease: String {
        return systemControl.osRelease ?? "Undefined"
    }

    var kernelVersion: String {
        return systemControl.kernelVersion ?? "Undefined"
    }

    var osBuild: String {
        guard let osBuild = systemControl.osBuild else {
            return "Undefined"
        }
        return "\(osBuild)"
    }
}

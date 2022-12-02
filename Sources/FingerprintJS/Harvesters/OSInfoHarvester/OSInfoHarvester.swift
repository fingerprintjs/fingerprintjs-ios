//
//  OSInfoHarvester.swift
//  FingerprintJS
//
//  Created by Petr Palata on 11.03.2022.
//

import Foundation

protocol OSInfoHarvesting {
    var osTimeZone: TimeZone { get }

    var osBuild: String { get }

    var osVersion: String { get }

    var osType: String { get }

    var osRelease: String { get }

    var kernelVersion: String { get }
}

struct OSInfoHarvester {
    private let systemControl: SystemControlValuesProviding
    private let timeZoneProvider: TimeZoneProvidable

    init(
        systemControl: SystemControlValuesProviding = SystemControl(),
        timeZoneProvider: TimeZoneProvidable = TimeZoneProvider()
    ) {
        self.systemControl = systemControl
        self.timeZoneProvider = timeZoneProvider
    }
}

extension OSInfoHarvester: OSInfoHarvesting {
    var osTimeZone: TimeZone {
        timeZoneProvider.current
    }

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

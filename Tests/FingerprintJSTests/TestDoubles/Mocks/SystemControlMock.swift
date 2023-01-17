import Foundation

@testable import FingerprintJS

#if !COCOAPODS
@testable import SystemControl
#endif

final class SystemControlMock: SystemControlValuesProviding {
    var mockHardwareModel: String?
    var mockHardwareMachine: String?
    var mockOsRelease: String?
    var mockOsType: String?
    var mockOsVersion: String?
    var mockKernelVersion: String?
    var mockOsBuild: Int32?
    var mockMemorySize: Int64?
    var mockPhysicalMemory: Int32?
    var mockCpuCount: Int32?
    var mockCpuFrequency: Int32?
    var mockBootTime: Date?
    var mockHostname: String?

    var hardwareModel: String? {
        return mockHardwareModel
    }

    var hardwareMachine: String? {
        return mockHardwareMachine
    }

    var osRelease: String? {
        return mockOsRelease
    }

    var osType: String? {
        return mockOsType
    }

    var osVersion: String? {
        return mockOsVersion
    }

    var kernelVersion: String? {
        return mockKernelVersion
    }

    var osBuild: Int32? {
        return mockOsBuild
    }

    var memorySize: Int64? {
        return mockMemorySize
    }

    var physicalMemory: Int32? {
        return mockPhysicalMemory
    }

    var cpuCount: Int32? {
        return mockCpuCount
    }

    var cpuFrequency: Int32? {
        return mockCpuFrequency
    }

    var bootTime: Date? {
        return mockBootTime
    }

    var hostname: String? {
        return mockHostname
    }
}

//
//  DeviceModelProvidingMock.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 08.04.2022.
//

import CoreGraphics
import Foundation

@testable import FingerprintJS

class DeviceModelProvidingMock: DeviceModelProviding {
    var mockModel = "Mock Device Model"
    var modelCalled = false

    var model: String {
        modelCalled = true
        return mockModel
    }
}

class ScreenSizeProvidingMock: ScreenSizeProviding {
    var mockNativeBounds = CGRect.zero
    var nativeBoundsCalled = false

    var nativeBounds: CGRect {
        nativeBoundsCalled = true
        return mockNativeBounds
    }
}

class SystemControlMock: SystemControlValuesProviding {
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
}

class CPUInfoProvidingMock: CPUInfoProviding {
    var processorCountCalled = true
    var mockProcessorCount = 0

    var processorCount: Int {
        processorCountCalled = true
        return mockProcessorCount
    }
}

class DocumentsDirectoryAttributesProvidingMock: DocumentsDirectoryAttributesProviding {
    var mockDocumentsDirectoryPath: String?
    var mockDocumentsDirectoryAttributes: [FileAttributeKey: Any] = [:]
    var mockDocumentsDirectoryAttributesError: Error?

    var documentsDirectoryPath: String? {
        return mockDocumentsDirectoryPath
    }

    func documentsDirectoryAttributes() throws -> [FileAttributeKey: Any] {
        if let error = mockDocumentsDirectoryAttributesError {
            throw error
        }
        return mockDocumentsDirectoryAttributes
    }
}

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

//
//  CPUInfoProvidingMock.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 11.04.2022.
//

import Foundation

@testable import FingerprintJS

class CPUInfoProvidingMock: CPUInfoProviding {
    var processorCountCalled = true
    var mockProcessorCount = 0

    var processorCount: Int {
        processorCountCalled = true
        return mockProcessorCount
    }
}

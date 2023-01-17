@testable import FingerprintJS

class CPUInfoProvidingMock: CPUInfoProviding {
    var processorCountCalled = true
    var mockProcessorCount = 0

    var processorCount: Int {
        processorCountCalled = true
        return mockProcessorCount
    }
}

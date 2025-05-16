@testable import FingerprintJS

@available(tvOS, unavailable)
final class CellularServiceInfoProvidingSpy: CellularServiceInfoProviding {

    var cellularProvidersReturnValue: [CarrierInfoProviding] = []
    var radioAccessTechnologiesReturnValue: [String] = []

    private(set) var cellularProvidersCallCount: Int = .zero
    private(set) var radioAccessTechnologiesCallCount: Int = .zero

    var cellularProviders: [CarrierInfoProviding] {
        cellularProvidersCallCount += 1
        return cellularProvidersReturnValue
    }

    var radioAccessTechnologies: [String] {
        radioAccessTechnologiesCallCount += 1
        return radioAccessTechnologiesReturnValue
    }
}

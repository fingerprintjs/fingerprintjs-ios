@testable import FingerprintJS

@available(tvOS, unavailable)
final class CellularServiceInfoProvidingSpy: CellularServiceInfoProviding {

    var cellularProvidersReturnValue: [CarrierInfoProviding] = []

    private(set) var cellularProvidersCallCount: Int = .zero

    var cellularProviders: [CarrierInfoProviding] {
        cellularProvidersCallCount += 1
        return cellularProvidersReturnValue
    }
}

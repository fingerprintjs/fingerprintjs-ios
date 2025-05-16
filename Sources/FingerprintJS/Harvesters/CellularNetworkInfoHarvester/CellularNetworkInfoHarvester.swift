#if canImport(CoreTelephony)
import CoreTelephony
#endif

@available(tvOS, unavailable)
protocol CellularNetworkInfoHarvesting {
    var mobileCountryCodes: [String] { get }
    var mobileNetworkCodes: [String] { get }
    var mobileNetworkTechnologies: [String] { get }
}

@available(tvOS, unavailable)
struct CellularNetworkInfoHarvester {

    private let cellularServiceInfoProvider: CellularServiceInfoProviding

    init(cellularServiceInfoProvider: CellularServiceInfoProviding) {
        self.cellularServiceInfoProvider = cellularServiceInfoProvider
    }
}

#if os(iOS)
extension CellularNetworkInfoHarvester {

    #if !targetEnvironment(simulator)
    init() {
        self.init(cellularServiceInfoProvider: CTTelephonyNetworkInfo())
    }
    #else
    private struct CellularServiceInfoProviderFake: CellularServiceInfoProviding {
        var cellularProviders: [CarrierInfoProviding] { [] }
        var radioAccessTechnologies: [String] { [] }
    }

    init() {
        self.init(cellularServiceInfoProvider: CellularServiceInfoProviderFake())
    }
    #endif
}

extension CellularNetworkInfoHarvester: CellularNetworkInfoHarvesting {

    var mobileCountryCodes: [String] {
        cellularServiceInfoProvider
            .cellularProviders
            .compactMap(\.mobileCountryCode)
            .sorted()
    }

    var mobileNetworkCodes: [String] {
        cellularServiceInfoProvider
            .cellularProviders
            .compactMap(\.mobileNetworkCode)
            .sorted()
    }

    var mobileNetworkTechnologies: [String] {
        cellularServiceInfoProvider
            .radioAccessTechnologies
            .sorted()
    }
}
#endif

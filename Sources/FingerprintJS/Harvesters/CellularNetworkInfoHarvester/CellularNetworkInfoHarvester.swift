#if canImport(CoreTelephony)
import CoreTelephony
#endif

@available(tvOS, unavailable)
protocol CellularNetworkInfoHarvesting {
    var mobileCountryCodes: [String] { get }
    var mobileNetworkCodes: [String] { get }
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

    init() {
        self.init(cellularServiceInfoProvider: CTTelephonyNetworkInfo())
    }
}

extension CellularNetworkInfoHarvester: CellularNetworkInfoHarvesting {

    var mobileCountryCodes: [String] {
        cellularServiceInfoProvider
            .cellularProviders
            .compactMap(\.mobileCountryCode)
    }

    var mobileNetworkCodes: [String] {
        cellularServiceInfoProvider
            .cellularProviders
            .compactMap(\.mobileNetworkCode)
    }
}
#endif

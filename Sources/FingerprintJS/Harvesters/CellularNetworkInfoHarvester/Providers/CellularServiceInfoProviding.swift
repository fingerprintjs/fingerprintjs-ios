#if canImport(CoreTelephony)
import CoreTelephony
#endif

@available(tvOS, unavailable)
protocol CellularServiceInfoProviding {
    var cellularProviders: [CarrierInfoProviding] { get }
}

#if os(iOS)
extension CTTelephonyNetworkInfo: CellularServiceInfoProviding {

    var cellularProviders: [CarrierInfoProviding] {
        serviceSubscriberCellularProviders?.values.compactMap { $0 } ?? []
    }
}
#endif

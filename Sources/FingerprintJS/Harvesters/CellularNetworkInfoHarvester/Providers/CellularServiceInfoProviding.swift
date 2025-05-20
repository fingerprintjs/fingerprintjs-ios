#if canImport(CoreTelephony)
import CoreTelephony
#endif

@available(tvOS, unavailable)
protocol CellularServiceInfoProviding {
    var cellularProviders: [CarrierInfoProviding] { get }
    var radioAccessTechnologies: [String] { get }
}

#if os(iOS)
extension CTTelephonyNetworkInfo: CellularServiceInfoProviding {

    var cellularProviders: [CarrierInfoProviding] {
        serviceSubscriberCellularProviders?.values.compactMap { $0 } ?? []
    }

    var radioAccessTechnologies: [String] {
        serviceCurrentRadioAccessTechnology?.values.compactMap { $0 } ?? []
    }
}
#endif

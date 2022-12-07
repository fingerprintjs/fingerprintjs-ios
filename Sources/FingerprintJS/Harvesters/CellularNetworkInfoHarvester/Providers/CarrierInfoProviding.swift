#if canImport(CoreTelephony)
import CoreTelephony
#endif

@available(tvOS, unavailable)
protocol CarrierInfoProviding {
    var mobileCountryCode: String? { get }
    var mobileNetworkCode: String? { get }
}

#if os(iOS)
extension CTCarrier: CarrierInfoProviding {}
#endif

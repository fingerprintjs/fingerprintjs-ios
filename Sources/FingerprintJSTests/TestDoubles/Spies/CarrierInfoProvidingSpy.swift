@testable import FingerprintJS

@available(tvOS, unavailable)
final class CarrierInfoProvidingSpy: CarrierInfoProviding {

    var mobileCountryCodeReturnValue: String?
    var mobileNetworkCodeReturnValue: String?

    private(set) var mobileCountryCodeCallCount: Int = .zero
    private(set) var mobileNetworkCodeCallCount: Int = .zero

    init(mobileCountryCode: String? = nil, mobileNetworkCode: String? = nil) {
        self.mobileCountryCodeReturnValue = mobileCountryCode
        self.mobileNetworkCodeReturnValue = mobileNetworkCode
    }

    var mobileCountryCode: String? {
        mobileCountryCodeCallCount += 1
        return mobileCountryCodeReturnValue
    }

    var mobileNetworkCode: String? {
        mobileNetworkCodeCallCount += 1
        return mobileNetworkCodeReturnValue
    }
}

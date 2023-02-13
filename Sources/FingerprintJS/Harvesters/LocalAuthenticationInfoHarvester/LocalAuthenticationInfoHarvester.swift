#if canImport(LocalAuthentication)
import LocalAuthentication
#endif

@available(tvOS, unavailable)
protocol LocalAuthenticationInfoHarvesting {
    var isPasscodeEnabled: Bool { get }
    var isBiometricsEnabled: Bool { get }
    var biometryType: BiometryType { get }
}

@available(tvOS, unavailable)
struct LocalAuthenticationInfoHarvester {

    private let authenticationContextInfoProvider: AuthenticationContextInfoProviding

    init(authenticationContextInfoProvider: AuthenticationContextInfoProviding) {
        self.authenticationContextInfoProvider = authenticationContextInfoProvider
    }
}

#if os(iOS)
extension LocalAuthenticationInfoHarvester {

    init() {
        self.init(authenticationContextInfoProvider: LAContext())
    }
}

extension LocalAuthenticationInfoHarvester: LocalAuthenticationInfoHarvesting {

    var isPasscodeEnabled: Bool {
        authenticationContextInfoProvider.isPasscodeEnabled
    }

    var isBiometricsEnabled: Bool {
        authenticationContextInfoProvider.isBiometricsEnabled
    }

    var biometryType: BiometryType {
        authenticationContextInfoProvider.supportedBiometryType
    }
}
#endif

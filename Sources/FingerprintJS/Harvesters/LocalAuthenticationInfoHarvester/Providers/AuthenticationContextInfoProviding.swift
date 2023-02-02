#if canImport(LocalAuthentication)
import LocalAuthentication
#endif

@available(tvOS, unavailable)
protocol AuthenticationContextInfoProviding {
    var isPasscodeEnabled: Bool { get }
    var isBiometricsEnabled: Bool { get }
    var supportedBiometryType: BiometryType { get }
}

#if os(iOS)
extension LAContext: AuthenticationContextInfoProviding {

    var isPasscodeEnabled: Bool {
        canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

    var isBiometricsEnabled: Bool {
        canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    var supportedBiometryType: BiometryType {
        if biometryType == .none {
            _ = canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        }

        return .init(biometryType)
    }
}
#endif

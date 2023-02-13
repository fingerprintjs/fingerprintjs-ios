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
            // As the LAContext documentation states, the biometryType property is
            // set only after the canEvaluatePolicy(_:error:) method is called,
            // and is set no matter what the call returns. The default value of this
            // property is LABiometryType.none, so with the below method call we make
            // sure that the property has the correct value.
            _ = canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        }

        return .init(biometryType)
    }
}
#endif

/// A collection of information about the local authentication settings.
@available(tvOS, unavailable)
public struct LocalAuthenticationInfo: Equatable, Encodable {
    /// A Boolean value indicating whether the device passcode is enabled.
    public let isPasscodeEnabled: Bool
    /// A Boolean value indicating whether the on-device biometric authentication is enabled.
    public let isBiometricsEnabled: Bool
    /// The type of biometric authentication supported by the device.
    public let biometryType: BiometryType
}

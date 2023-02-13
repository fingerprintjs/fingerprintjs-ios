#if canImport(LocalAuthentication)
import LocalAuthentication
#endif

/// Constants that indicate the type of biometric authentication supported by the device.
@available(tvOS, unavailable)
public enum BiometryType: String, Encodable {
    /// The device supports Face ID.
    case faceID
    /// The device supports Touch ID.
    case touchID
    /// Biometric authentication is not supported.
    case none
    /// The device supports some unknown type of biometric authentication.
    case unknown
}

#if os(iOS)
extension BiometryType: CustomStringConvertible {

    /// A textual representation of this value.
    public var description: String {
        switch self {
        case .faceID:
            return "Face ID"
        case .touchID:
            return "Touch ID"
        case .none, .unknown:
            return "<\(rawValue)>"
        }
    }
}

extension BiometryType {

    init(_ biometryType: LABiometryType) {
        switch biometryType {
        case .faceID:
            self = .faceID
        case .touchID:
            self = .touchID
        case .none:
            self = .none
        @unknown default:
            self = .unknown
        }
    }
}
#endif

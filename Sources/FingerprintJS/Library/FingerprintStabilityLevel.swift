/// A stability level that indicates which signals are to be included when computing the fingerprint.
///
/// The more stable the signal is, the less likely it is to change over time for a particular device.
public enum FingerprintStabilityLevel: Int {
    /// A stability level that is recommended for obtaining the most accurate fingerprint.
    case unique = -2
    /// A stability level that is recommended as providing the best balance between fingerprint stability and fingerprint accuracy.
    case optimal = -1
    /// A stability level that is recommended for obtaining the most stable fingerprint.
    case stable = 0
}

extension FingerprintStabilityLevel: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

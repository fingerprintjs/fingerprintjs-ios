/// Enumeration of available fingerprinting algorithms.
public enum FingerprintAlgorithm {
    /// Default fingerprinting function that uses the SHA256 algorithm to compute the fingerprint.
    case sha256
    /// Used for purposes where the library user wants to use their own `FingerprintFunction` algorithm.
    case custom(FingerprintFunction)
}

/// `FingerprintJS`'s configuration.
public struct Configuration {
    let version: FingerprintJSVersion
    let stabilityLevel: FingerprintStabilityLevel
    let algorithm: FingerprintAlgorithm

    /// Creates configuration object with the specified options.
    /// - Parameters:
    ///   - version: The fingerprint version.
    ///   - stabilityLevel: The desired stability level of the computed fingerprint. Note that in fingerprint versions ``FingerprintJSVersion/v1`` and ``FingerprintJSVersion/v2``, the value of this parameter is ignored.
    ///   - algorithm: The algorithm used for computing the fingerprint.
    public init(
        version: FingerprintJSVersion = .latest,
        stabilityLevel: FingerprintStabilityLevel = .optimal,
        algorithm: FingerprintAlgorithm = .sha256
    ) {
        self.version = version
        self.stabilityLevel = stabilityLevel
        self.algorithm = algorithm
    }

    var hashFunction: FingerprintFunction {
        switch algorithm {
        case .sha256:
            return SHA256HashingFunction()
        case let .custom(fingerprintFunction):
            return fingerprintFunction
        }
    }
}

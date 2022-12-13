/// Enumeration of available FingerprintJS versions.
public enum FingerprintJSVersion {
    /// Version 1.
    case v1
    /// Version 2.
    case v2
    /// Version 3.
    case v3
}

/// Enumeration of available fingerprinting algorithms
public enum FingerprintAlgorithm {
    /// Default fingerprinting function that uses the SHA256 algorithm to compute the fingerprint
    case sha256

    /// Used for purposes where the library user wants to use their own `FingerprintFunction` algorithm
    case custom(FingerprintFunction)
}

/// `FingerprintJS`'s configuration
public struct Configuration {
    let version: FingerprintJSVersion
    let algorithm: FingerprintAlgorithm

    public init(version: FingerprintJSVersion = .v3, algorithm: FingerprintAlgorithm = .sha256) {
        self.version = version
        self.algorithm = algorithm
    }

    var hashFunction: FingerprintFunction {
        switch algorithm {
        case .sha256:
            return SHA256HashingFunction()
        case .custom(let fingerprintFunction):
            return fingerprintFunction
        }
    }
}

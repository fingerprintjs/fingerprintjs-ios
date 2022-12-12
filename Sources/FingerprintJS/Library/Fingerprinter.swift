/// Main `FingerprintJS` class that provides an interface to all library functions (device identifier and fingerprint retrieval)
public class Fingerprinter {
    private let configuration: Configuration
    private let identifiers: IdentifierHarvesting
    private let treeProvider: DeviceInfoTreeProvider
    private let fingerprintCalculator: FingerprintTreeCalculator

    convenience init(_ configuration: Configuration) {
        self.init(
            configuration,
            identifiers: IdentifierHarvester(),
            deviceInfoTree: CompoundTreeBuilder(),
            fingerprintCalculator: FingerprintTreeCalculator()
        )
    }

    init(
        _ configuration: Configuration,
        identifiers: IdentifierHarvesting,
        deviceInfoTree: DeviceInfoTreeProvider,
        fingerprintCalculator: FingerprintTreeCalculator
    ) {
        self.configuration = configuration
        self.identifiers = identifiers
        self.treeProvider = deviceInfoTree
        self.fingerprintCalculator = fingerprintCalculator
    }

}

// MARK: - Public Interface
extension Fingerprinter {
    /// Retrieves a stable device identifier that is tied to the current device/application combination
    /// - Parameter completion: Block called with the device identifier `String` value or `nil` if an error occurs
    /// - SeeAlso: [Device Identifier and Fingerprint Stability](https://github.com/fingerprintjs/fingerprintjs-ios#device_identifier_and_fingerprint_stability)
    public func getDeviceId(_ completion: @escaping (String?) -> Void) {
        completion(self.identifiers.vendorIdentifier?.uuidString)
    }

    /// Computes device fingerprint from a combination of hardware information and device identifiers.
    ///
    /// The fingerprint is computed with a hash function previously specified through the `Configuration`
    /// object that was passed through the initializer
    ///  - Parameter completion: Block called with a `String` representing the fingerprint or `nil` if any error occured
    public func getFingerprint(_ completion: @escaping (String?) -> Void) {
        getFingerprintTree { deviceItem in
            completion(deviceItem.fingerprint)
        }
    }

    /// Gets fingerprint information in its raw form (includes both the data and the fingerprint itself) as a tree of
    /// fingerprinted `DeviceItemInfo` items.
    ///
    /// - Parameter completion: Block called with `FingerprintTree` object that encapsulates both
    /// the hardware information as well as the final computed fingerprint.
    public func getFingerprintTree(_ completion: @escaping (FingerprintTree) -> Void) {
        let inputTree = treeProvider.buildTree(configuration)
        let fingerprintTree = fingerprintCalculator.calculateFingerprints(
            from: inputTree,
            hashFunction: configuration.hashFunction
        )
        completion(fingerprintTree)
    }
}

// MARK: - Public Interface: Async/Await (iOS 13+)
@available(iOS 13.0, tvOS 13.0, *)
extension Fingerprinter {
    /// Retrieves a stable device identifier that is tied to the current device/application combination
    /// - Returns: Device identifier `String` value or `nil` if an error occurs
    /// - SeeAlso: [Device Identifier and Fingerprint Stability](https://github.com/fingerprintjs/fingerprintjs-ios#device_identifier_and_fingerprint_stability)
    public func getDeviceId() async -> String? {
        return await withCheckedContinuation({ continuation in
            self.getDeviceId { deviceId in
                continuation.resume(with: .success(deviceId))
            }
        })
    }

    /// Gets fingerprint information in its raw form (includes both the data and the fingerprint itself) as a tree of
    /// fingerprinted `DeviceItemInfo` items.
    ///
    /// - Returns: `FingerprintTree` object that encapsulates both the hardware information as well as the final computed fingerprint.
    public func getFingerprintTree() async -> FingerprintTree {
        return await withCheckedContinuation({ continuation in
            self.getFingerprintTree({ tree in
                continuation.resume(with: .success(tree))
            })
        })
    }

    /// Computes device fingerprint from a combination of hardware information and device identifiers.
    ///
    /// The fingerprint is computed with a hash function previously specified through the `Configuration`
    /// object that was passed through the initializer
    ///  - Returns: `String` representing the fingerprint or `nil` if any error occured
    public func getFingerprint() async -> String? {
        return await withCheckedContinuation({ continuation in
            self.getFingerprint { fingerprint in
                continuation.resume(with: .success(fingerprint))
            }
        })
    }
}

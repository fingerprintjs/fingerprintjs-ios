import Foundation

/// An interface representing hashing algorithm that is used to compute a `String` fingerprint from `Data`.
public protocol FingerprintFunction {
    /// Computes fingerprint from the given data.
    /// - Parameter data: Input `Data`.
    /// - Returns: Fingerprint computed from the input data in its `String` form.
    func fingerprint(data: Data) -> String
}

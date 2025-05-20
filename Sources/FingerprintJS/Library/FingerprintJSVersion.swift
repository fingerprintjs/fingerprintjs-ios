/// Enumeration of available fingerprint versions.
public enum FingerprintJSVersion {
    /// Version 1.
    case v1
    /// Version 2.
    case v2
    /// Version 3.
    case v3
    /// Version 4.
    case v4
    /// Version 5.
    case v5
    /// Version 6.
    case v6
}

extension FingerprintJSVersion {
    /// Latest fingerprint version.
    public static var latest: Self { .v6 }
}

extension FingerprintJSVersion: CaseIterable, Equatable {}

extension Array where Element == FingerprintJSVersion {
    static var all: Self {
        Element.allCases
    }

    static func since(_ version: Element) -> Self {
        guard let index = all.firstIndex(of: version) else {
            return []
        }
        return .init(all[index...])
    }
}

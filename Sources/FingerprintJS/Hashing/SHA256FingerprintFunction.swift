import CommonCrypto
import CryptoKit
import Foundation

class SHA256HashingFunction: FingerprintFunction {
    public func fingerprint(data: Data) -> String {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return computeSHA256CryptoKit(data)
        } else {
            return computeSHA256CommonCrypto(data)
        }
    }

    @available(iOS 13.0, tvOS 13.0, *)
    func computeSHA256CryptoKit(_ data: Data) -> String {
        let digest = SHA256.hash(data: data)
        return digest.hexStr
    }

    func computeSHA256CommonCrypto(_ data: Data) -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        let digest = Data(hash)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

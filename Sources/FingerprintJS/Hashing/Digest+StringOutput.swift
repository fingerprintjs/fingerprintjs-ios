import CryptoKit
import Foundation

@available(iOS 13.0, tvOS 13.0, *)
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { .init(format: "%02x", $0) }.joined()
    }
}

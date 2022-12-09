import Foundation

class FingerprintTreeCalculator {
    func calculateFingerprints(from tree: DeviceInfoItem, hashFunction: FingerprintFunction) -> FingerprintTree {
        if let children = tree.children {
            let fingerprintedChildren = children.map {
                calculateFingerprints(from: $0, hashFunction: hashFunction)
            }

            let childrenFingeprintData = fingerprintedChildren.reduce(Data()) { prev, item in
                return prev + item.fingerprintData
            }

            let fingerprint = hashFunction.fingerprint(data: childrenFingeprintData)
            return FingerprintTree(
                info: tree,
                children: fingerprintedChildren,
                fingerprintData: fingerprint.data(using: .ascii) ?? Data()
            )
        } else {
            return FingerprintTree(
                info: tree,
                children: nil,
                fingerprintData: tree.fingerprint(using: hashFunction).data(using: .ascii) ?? Data()
            )
        }
    }
}

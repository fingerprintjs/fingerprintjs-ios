import FingerprintJS
import UIKit

/// HardwareInfoHarvester
let hardwareInfo = HardwareInfoHarvester()
hardwareInfo.deviceType
hardwareInfo.deviceModel
hardwareInfo.displayResolution

let identifiers = IdentifierHarvester()
identifiers.vendorIdentifier

let osInfo = OSInfoHarvester()
osInfo.osType
osInfo.osVersion
osInfo.kernelVersion
osInfo.osRelease

let hardwareFingerprint = HardwareFingerprint()
hardwareFingerprint.fingerprint()

let identifierFingerprint = IdentifierFingerprint()
identifierFingerprint.fingerprint(using: SHA256HashingFunction())

DeviceFingerprint.fingerprint

let fingerprinter = FingerprinterFactory.getInstance()
fingerprinter.getDeviceId {
    print($0)
}

fingerprinter.getFingerprint {
    print($0)
}

Task {
    await fingerprinter.getFingerprint()
    await fingerprinter.getDeviceId()
    await fingerprinter.getFingerprintTree()
}

let fingerprintTreeBuilder = FingerprintTreeBuilder()
let fingerprintTree = fingerprintTreeBuilder.buildTree(Configuration())
print(fingerprintTree.description)

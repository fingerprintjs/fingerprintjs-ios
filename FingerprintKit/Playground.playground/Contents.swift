import FingerprintKit
import UIKit

/**
 HardwareInfoHarvester
 */
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


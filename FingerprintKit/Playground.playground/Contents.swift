import FingerprintKit
import UIKit

let hardwareSignals = HardwareSignals(UIDevice.current)

let deviceModelSignal =  hardwareSignals.deviceModelSignal


deviceModelSignal.value
deviceModelSignal.hash

if let deviceIdentifierSignal = hardwareSignals.deviceIdentifierSignal {
    deviceIdentifierSignal.value
    deviceIdentifierSignal.hash
}

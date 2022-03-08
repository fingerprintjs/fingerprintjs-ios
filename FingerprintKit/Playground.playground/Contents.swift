import FingerprintKit
import UIKit

let hardwareSignals = HardwareSignals(UIDevice.current)

let deviceModelSignal =  hardwareSignals.deviceModelSignal


deviceModelSignal.value
deviceModelSignal.hash

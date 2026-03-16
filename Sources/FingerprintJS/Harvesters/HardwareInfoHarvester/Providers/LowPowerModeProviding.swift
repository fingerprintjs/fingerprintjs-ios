import Foundation

protocol LowPowerModeProviding {
    var isLowPowerModeEnabled: Bool { get }
}

extension ProcessInfo: LowPowerModeProviding {}

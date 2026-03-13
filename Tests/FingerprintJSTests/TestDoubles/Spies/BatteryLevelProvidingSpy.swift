@testable import FingerprintJS

final class BatteryLevelProvidingSpy: BatteryLevelProviding {

    var isBatteryMonitoringEnabledReturnValue: Bool = false
    var batteryLevelReturnValue: Float = -1

    private(set) var isBatteryMonitoringEnabledCallCount: Int = .zero
    private(set) var batteryLevelCallCount: Int = .zero

    var isBatteryMonitoringEnabled: Bool {
        get {
            isBatteryMonitoringEnabledCallCount += 1
            return isBatteryMonitoringEnabledReturnValue
        }
        set {
            isBatteryMonitoringEnabledCallCount += 1
            isBatteryMonitoringEnabledReturnValue = newValue
        }
    }

    var batteryLevel: Float {
        batteryLevelCallCount += 1
        return batteryLevelReturnValue
    }
}

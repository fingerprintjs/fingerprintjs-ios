import UIKit

protocol BatteryLevelProviding: AnyObject {
    var isBatteryMonitoringEnabled: Bool { get set }
    var batteryLevel: Float { get }
}

#if os(iOS)
extension UIDevice: BatteryLevelProviding {}
#endif

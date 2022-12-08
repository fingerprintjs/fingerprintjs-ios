import UIKit

protocol DeviceIdentificationInfoProviding {
    var model: String { get }
    var userAssignedName: String { get }
}

extension UIDevice: DeviceIdentificationInfoProviding {

    var userAssignedName: String {
        if #available(iOS 16.0, tvOS 16.0, *) {
            return ""
        }

        return name
    }
}

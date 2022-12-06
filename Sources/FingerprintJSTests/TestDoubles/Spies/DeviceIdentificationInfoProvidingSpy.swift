@testable import FingerprintJS

final class DeviceIdentificationInfoProvidingSpy: DeviceIdentificationInfoProviding {

    var modelReturnValue: String = ""
    var userAssignedNameReturnValue: String = ""

    private(set) var modelCallCount: Int = .zero
    private(set) var userAssignedNameCallCount: Int = .zero

    var model: String {
        modelCallCount += 1
        return modelReturnValue
    }

    var userAssignedName: String {
        userAssignedNameCallCount += 1
        return userAssignedNameReturnValue
    }
}

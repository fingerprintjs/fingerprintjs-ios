public protocol DeviceInfoProviding {
    /// Gathers and returns all information about the device
    /// - Returns: `DeviceInfo` object that contains typed representation of device information values
    @available(iOS 13.0, tvOS 13.0, *)
    func getDeviceInfo() async -> DeviceInfo

    /// Gathers all information about the device and reports it through the completion block
    /// - Parameter completion: Completion block reporting the `DeviceInfo` object
    func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void)
}

public class DeviceInfoProvider {
    private let identifierHarvester: IdentifierHarvesting
    private let appInfoHarvester: AppInfoHarvesting
    private let hardwareInfoHarvester: HardwareInfoHarvesting
    private let osInfoHarvester: OSInfoHarvesting

    public convenience init() {
        self.init(
            identifierHarvester: IdentifierHarvester(),
            appInfoHarvester: AppInfoHarvester(),
            hardwareInfoHarvester: HardwareInfoHarvester(),
            osInfoHarvester: OSInfoHarvester()
        )
    }

    init(
        identifierHarvester: IdentifierHarvesting,
        appInfoHarvester: AppInfoHarvesting,
        hardwareInfoHarvester: HardwareInfoHarvesting,
        osInfoHarvester: OSInfoHarvesting
    ) {
        self.identifierHarvester = identifierHarvester
        self.appInfoHarvester = appInfoHarvester
        self.hardwareInfoHarvester = hardwareInfoHarvester
        self.osInfoHarvester = osInfoHarvester
    }
}

extension DeviceInfoProvider: DeviceInfoProviding {

    @available(iOS 13.0, tvOS 13.0, *)
    public func getDeviceInfo() async -> DeviceInfo {
        return await withCheckedContinuation { continuation in
            self.getDeviceInfo { deviceInfo in
                continuation.resume(returning: deviceInfo)
            }
        }
    }

    public func getDeviceInfo(_ completion: @escaping (DeviceInfo) -> Void) {
        let deviceInfo = DeviceInfo(
            vendorIdentifier: identifierHarvester.vendorIdentifier,
            userInterfaceStyle: appInfoHarvester.userInterfaceStyle,
            diskSpace: hardwareInfoHarvester.diskSpaceInfo,
            screenResolution: hardwareInfoHarvester.displayResolution,
            screenScale: hardwareInfoHarvester.displayScale,
            deviceType: hardwareInfoHarvester.deviceType,
            deviceModel: hardwareInfoHarvester.deviceModel,
            memorySize: hardwareInfoHarvester.memorySize,
            physicalMemory: hardwareInfoHarvester.memorySize,
            cpuCount: hardwareInfoHarvester.cpuCount,
            osTimeZoneIdentifier: osInfoHarvester.osTimeZoneIdentifier,
            osBuild: osInfoHarvester.osBuild,
            osVersion: osInfoHarvester.osVersion,
            osType: osInfoHarvester.osType,
            osRelease: osInfoHarvester.osRelease,
            kernelVersion: osInfoHarvester.kernelVersion
        )

        completion(deviceInfo)
    }
}

import Foundation

public struct DeviceInfo: Equatable, Encodable {
    public let vendorIdentifier: UUID?

    /// The identifier for the locale representing the user's region settings.
    public let localeIdentifier: String
    /// The style associated with the user interface of the app.
    public let userInterfaceStyle: UserInterfaceStyle

    public let diskSpace: DiskSpaceInfo?
    public let screenResolution: CGSize?
    /// The native scale factor for the screen.
    public let screenScale: CGFloat
    /// The user-assigned device name.
    @available(
        iOS,
        deprecated: 16.0,
        message: "User-assigned device name cannot be used for fingerprinting in iOS 16 and later."
    )
    @available(
        tvOS,
        deprecated: 16.0,
        message: "User-assigned device name cannot be used for fingerprinting in tvOS 16 and later."
    )
    public let deviceName: String
    public let deviceType: String?
    public let deviceModel: String?
    public let memorySize: String?
    public let physicalMemory: String?
    public let cpuCount: String?

    /// Hostname of the device.
    public let kernelHostname: String

    /// The geopolitical region identifier of the operating system's current time zone.
    public let osTimeZoneIdentifier: String
    public let osBuild: String?
    public let osVersion: String?
    public let osType: String?
    public let osRelease: String?
    public let kernelVersion: String?

    /// Last device boot time in RFC3339 format.
    public let bootTime: String

    /// The mobile country codes (MCCs) for the user’s cellular service providers.
    @available(
        iOS,
        deprecated: 16.0,
        message: "The return value is undefined and no guarantee can be made on its stability."
    )
    @available(tvOS, unavailable)
    public let mobileCountryCodes: [String]
    /// The mobile network codes (MNCs) for the user’s cellular service providers.
    @available(
        iOS,
        deprecated: 16.0,
        message: "The return value is undefined and no guarantee can be made on its stability."
    )
    @available(tvOS, unavailable)
    public let mobileNetworkCodes: [String]
}

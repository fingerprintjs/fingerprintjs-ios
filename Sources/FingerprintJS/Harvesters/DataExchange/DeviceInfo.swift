import Foundation

public struct DeviceInfo: Equatable, Encodable {
    #if os(iOS)
    private let _mobileCountryCodes: [String]
    private let _mobileNetworkCodes: [String]
    private let _mobileNetworkTechnologies: [String]
    private let _localAuthentication: LocalAuthenticationInfo
    #endif

    public let vendorIdentifier: UUID?

    /// The identifier for the locale representing the user's language and region settings.
    public let localeIdentifier: String
    /// The style associated with the user interface of the app.
    public let userInterfaceStyle: UserInterfaceStyle

    @available(
        *,
        deprecated,
        message: "DeviceInfo.diskSpace is always nil and will be removed in a future library version"
    )
    public let diskSpace: DiskSpaceInfo? = nil

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
    public var mobileCountryCodes: [String] {
        #if os(iOS)
        _mobileCountryCodes
        #else
        []
        #endif
    }
    /// The mobile network codes (MNCs) for the user’s cellular service providers.
    @available(
        iOS,
        deprecated: 16.0,
        message: "The return value is undefined and no guarantee can be made on its stability."
    )
    @available(tvOS, unavailable)
    public var mobileNetworkCodes: [String] {
        #if os(iOS)
        _mobileNetworkCodes
        #else
        []
        #endif
    }
    public var mobileNetworkTechnologies: [String] {
        #if os(iOS)
        _mobileNetworkTechnologies
        #else
        []
        #endif
    }

    /// The information about the local authentication settings.
    @available(tvOS, unavailable)
    public var localAuthentication: LocalAuthenticationInfo {
        #if os(iOS)
        _localAuthentication
        #else
        .init(
            isPasscodeEnabled: false,
            isBiometricsEnabled: false,
            biometryType: .none
        )
        #endif
    }
}

extension DeviceInfo {

    #if os(iOS)
    init(
        vendorIdentifier: UUID?,
        localeIdentifier: String,
        userInterfaceStyle: UserInterfaceStyle,
        screenResolution: CGSize?,
        screenScale: CGFloat,
        deviceName: String,
        deviceType: String?,
        deviceModel: String?,
        memorySize: String?,
        physicalMemory: String?,
        cpuCount: String?,
        kernelHostname: String,
        osTimeZoneIdentifier: String,
        osBuild: String?,
        osVersion: String?,
        osType: String?,
        osRelease: String?,
        kernelVersion: String?,
        bootTime: String,
        mobileCountryCodes: [String],
        mobileNetworkCodes: [String],
        mobileNetworkTechnologies: [String],
        localAuthentication: LocalAuthenticationInfo
    ) {
        self.vendorIdentifier = vendorIdentifier
        self.localeIdentifier = localeIdentifier
        self.userInterfaceStyle = userInterfaceStyle
        self.screenResolution = screenResolution
        self.screenScale = screenScale
        self.deviceName = deviceName
        self.deviceType = deviceType
        self.deviceModel = deviceModel
        self.memorySize = memorySize
        self.physicalMemory = physicalMemory
        self.cpuCount = cpuCount
        self.kernelHostname = kernelHostname
        self.osTimeZoneIdentifier = osTimeZoneIdentifier
        self.osBuild = osBuild
        self.osVersion = osVersion
        self.osType = osType
        self.osRelease = osRelease
        self.kernelVersion = kernelVersion
        self.bootTime = bootTime
        self._mobileCountryCodes = mobileCountryCodes
        self._mobileNetworkCodes = mobileNetworkCodes
        self._mobileNetworkTechnologies = mobileNetworkTechnologies
        self._localAuthentication = localAuthentication
    }
    #endif
}

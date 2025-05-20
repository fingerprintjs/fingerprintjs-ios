protocol DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem

    typealias AnnotatedInfoItem = (
        item: DeviceInfoItem,
        stabilityLevel: FingerprintStabilityLevel,
        versions: [FingerprintJSVersion]
    )

    var annotatedItems: [AnnotatedInfoItem] { get }
}

extension DeviceInfoTreeProvider {
    fileprivate func itemsMatching(configuration: Configuration) -> [DeviceInfoItem] {
        let isMatchingItem: (AnnotatedInfoItem) -> Bool
        switch configuration.version {
        case .v1, .v2:
            isMatchingItem = { annotatedItem in
                annotatedItem.versions.contains(configuration.version)
            }
        default:
            isMatchingItem = { annotatedItem in
                annotatedItem.stabilityLevel >= configuration.stabilityLevel
                    && annotatedItem.versions.contains(configuration.version)
            }
        }

        return
            annotatedItems
            .filter(isMatchingItem)
            .map(\.item)
    }
}

extension AppInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "App",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Locale identifier",
                    value: .info(localeIdentifier)
                ),
                stabilityLevel: .unique,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "User interface style",
                    value: .info(userInterfaceStyle.rawValue)
                ),
                stabilityLevel: .unique,
                versions: .since(.v3)
            ),
        ]
    }
}

extension HardwareInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "Hardware",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Device name",
                    value: .info(deviceName)
                ),
                stabilityLevel: .unique,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Device type",
                    value: .info(deviceType)
                ),
                stabilityLevel: .stable,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Device model",
                    value: .info(deviceModel)
                ),
                stabilityLevel: .stable,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Display resolution",
                    value: .info(displayResolution.description)
                ),
                stabilityLevel: .stable,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Display scale",
                    value: .info(displayScale.description)
                ),
                stabilityLevel: .stable,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Physical memory",
                    value: .info(memorySize)
                ),
                stabilityLevel: .stable,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Processor count",
                    value: .info(cpuCount)
                ),
                stabilityLevel: .stable,
                versions: .all
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Device hostname",
                    value: .info(kernelHostname)

                ),
                stabilityLevel: .unique,
                versions: .since(.v4)
            ),
        ]
    }
}

extension IdentifierHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "Identifiers",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Vendor identifier",
                    value: .info(vendorIdentifier?.uuidString ?? "No identifier")
                ),
                stabilityLevel: .optimal,
                versions: .all
            )
        ]
    }
}

extension OSInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "Operating System",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS time zone identifier",
                    value: .info(osTimeZoneIdentifier)
                ),
                stabilityLevel: .optimal,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS release",
                    value: .info(osRelease)
                ),
                stabilityLevel: .optimal,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS type",
                    value: .info(osType)
                ),
                stabilityLevel: .optimal,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS version",
                    value: .info(osVersion)
                ),
                stabilityLevel: .optimal,
                versions: .all
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Kernel version",
                    value: .info(kernelVersion)
                ),
                stabilityLevel: .optimal,
                versions: .all
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Boot time",
                    value: .info(bootTime)

                ),
                stabilityLevel: .optimal,
                versions: .since(.v4)
            ),
        ]
    }
}

#if os(iOS)
extension CellularNetworkInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "Cellular Network",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Mobile country codes",
                    value: .info(mobileCountryCodes.description)
                ),
                stabilityLevel: .unique,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Mobile network codes",
                    value: .info(mobileNetworkCodes.description)
                ),
                stabilityLevel: .unique,
                versions: .since(.v3)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Mobile network technologies",
                    value: .info(mobileNetworkTechnologies.description)
                ),
                stabilityLevel: .unique,
                versions: .since(.v6)
            ),
        ]
    }
}

extension LocalAuthenticationInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        .init(
            label: "Local Authentication",
            value: .category,
            children: itemsMatching(configuration: configuration)
        )
    }

    var annotatedItems: [AnnotatedInfoItem] {
        [
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Passcode",
                    value: .info(isPasscodeEnabled ? "Enabled" : "Disabled")
                ),
                stabilityLevel: .optimal,
                versions: .since(.v5)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Biometrics",
                    value: .info(isBiometricsEnabled ? "Enabled" : "Disabled")
                ),
                stabilityLevel: .optimal,
                versions: .since(.v5)
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Biometry type",
                    value: .info(biometryType.description)
                ),
                stabilityLevel: .stable,
                versions: .since(.v5)
            ),
        ]
    }
}
#endif

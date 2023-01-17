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
                versions: [.v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "User interface style",
                    value: .info(userInterfaceStyle.rawValue)
                ),
                stabilityLevel: .unique,
                versions: [.v3]
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
                versions: [.v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Device type",
                    value: .info(deviceType)
                ),
                stabilityLevel: .stable,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Device model",
                    value: .info(deviceModel)
                ),
                stabilityLevel: .stable,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Display resolution",
                    value: .info(displayResolution.description)
                ),
                stabilityLevel: .stable,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Display scale",
                    value: .info(displayScale.description)
                ),
                stabilityLevel: .stable,
                versions: [.v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Physical memory",
                    value: .info(memorySize)
                ),
                stabilityLevel: .stable,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Processor count",
                    value: .info(cpuCount)
                ),
                stabilityLevel: .stable,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Free disk space (B)",
                    value: .info(String(describing: freeDiskSpace))
                ),
                stabilityLevel: .unique,
                versions: [.v2, .v3]
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Total disk space (B)",
                    value: .info(String(describing: totalDiskSpace))
                ),
                stabilityLevel: .stable,
                versions: [.v2, .v3]
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Device hostname",
                    value: .info(kernelHostname)

                ),
                stabilityLevel: .unique,
                versions: []
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
                versions: [.v1, .v2, .v3]
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
                versions: [.v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS release",
                    value: .info(osRelease)
                ),
                stabilityLevel: .optimal,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS type",
                    value: .info(osType)
                ),
                stabilityLevel: .optimal,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "OS version",
                    value: .info(osVersion)
                ),
                stabilityLevel: .optimal,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Kernel version",
                    value: .info(kernelVersion)
                ),
                stabilityLevel: .optimal,
                versions: [.v1, .v2, .v3]
            ),
            AnnotatedInfoItem(
                DeviceInfoItem(
                    label: "Boot time",
                    value: .info(bootTime)

                ),
                stabilityLevel: .optimal,
                versions: []
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
                versions: [.v3]
            ),
            AnnotatedInfoItem(
                item: DeviceInfoItem(
                    label: "Mobile network codes",
                    value: .info(mobileNetworkCodes.description)
                ),
                stabilityLevel: .unique,
                versions: [.v3]
            ),
        ]
    }
}
#endif

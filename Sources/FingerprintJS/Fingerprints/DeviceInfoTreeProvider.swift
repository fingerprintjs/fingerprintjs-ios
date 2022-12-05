protocol DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem

    typealias VersionedInfoItem = (item: DeviceInfoItem, versions: [FingerprintJSVersion])

    var versionedItems: [VersionedInfoItem] { get }
}

extension DeviceInfoTreeProvider {
    func itemsForVersion(_ version: FingerprintJSVersion) -> [DeviceInfoItem] {
        return
            versionedItems
            .filter { $0.versions.contains(version) }
            .map { $0.item }
    }
}

extension AppInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "App",
            value: .category,
            children: itemsForVersion(configuration.version)
        )
    }

    var versionedItems: [VersionedInfoItem] {
        [
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Locale identifier",
                    value: .info(localeIdentifier)
                ),
                versions: []
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "User interface style",
                    value: .info(userInterfaceStyle.rawValue)
                ),
                versions: []
            ),
        ]
    }
}

extension HardwareInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Hardware",
            value: .category,
            children: itemsForVersion(configuration.version)
        )
    }

    var versionedItems: [VersionedInfoItem] {
        return [
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Device type",
                    value: .info(deviceType)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Device model",
                    value: .info(deviceModel)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Display resolution",
                    value: .info(displayResolution.description)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Display scale",
                    value: .info(displayScale.description)
                ),
                versions: []
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Physical memory",
                    value: .info(memorySize)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Processor count",
                    value: .info(cpuCount)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                DeviceInfoItem(
                    label: "Free disk space (B)",
                    value: .info(String(describing: freeDiskSpace))
                ),
                versions: [.v2]
            ),
            VersionedInfoItem(
                DeviceInfoItem(
                    label: "Total disk space (B)",
                    value: .info(String(describing: totalDiskSpace))
                ),
                versions: [.v2]
            ),
        ]
    }
}

extension IdentifierHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Identifiers",
            value: .category,
            children: itemsForVersion(configuration.version)
        )
    }

    var versionedItems: [VersionedInfoItem] {
        return [
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Vendor identifier",
                    value: .info(vendorIdentifier?.uuidString ?? "No identifier")
                ),
                versions: [.v1, .v2]
            )
        ]
    }
}

extension OSInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Operating System",
            value: .category,
            children: itemsForVersion(configuration.version)
        )
    }

    var versionedItems: [VersionedInfoItem] {
        return [
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "OS time zone identifier",
                    value: .info(osTimeZoneIdentifier)
                ),
                versions: []
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "OS release",
                    value: .info(osRelease)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "OS type",
                    value: .info(osType)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "OS version",
                    value: .info(osVersion)
                ),
                versions: [.v1, .v2]
            ),
            VersionedInfoItem(
                item: DeviceInfoItem(
                    label: "Kernel version",
                    value: .info(kernelVersion)
                ),
                versions: [.v1, .v2]
            ),
        ]
    }
}

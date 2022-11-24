struct CompoundTreeBuilder {
    private let providers: [DeviceInfoTreeProvider]

    init() {
        self.init(providers: [
            AppInfoHarvester(),
            HardwareInfoHarvester(),
            OSInfoHarvester(),
            IdentifierHarvester(),
        ])
    }

    init(providers: [DeviceInfoTreeProvider]) {
        self.providers = providers
    }
}

extension CompoundTreeBuilder: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        let children = providers.map { $0.buildTree(configuration) }

        return DeviceInfoItem(
            label: "Device Fingerprint",
            value: .category,
            children: children
        )
    }

    var versionedItems: [VersionedInfoItem] {
        return []
    }
}

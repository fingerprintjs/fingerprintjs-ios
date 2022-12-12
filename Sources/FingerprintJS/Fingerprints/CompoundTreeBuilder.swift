struct CompoundTreeBuilder {
    private let providers: [DeviceInfoTreeProvider]

    init() {
        var providers: [DeviceInfoTreeProvider] = [
            AppInfoHarvester(),
            HardwareInfoHarvester(),
            OSInfoHarvester(),
            IdentifierHarvester(),
        ]
        #if os(iOS)
        providers.append(CellularNetworkInfoHarvester())
        #endif
        self.init(providers: providers)
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

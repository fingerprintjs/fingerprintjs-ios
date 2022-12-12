/// Types of `DeviceInfoItem` values
public enum DeviceInfoValueType {
    /// `DeviceInfoItem` that contains category information and child items
    case category

    /// `DeviceInfoItem` that describes a leaf node and contains single piece of fingerprintable device information
    case info(String)
}

/// Single piece (or a category) of device information encapsulated in a structure
public struct DeviceInfoItem {
    /// The name of the underlying value
    public let label: String

    /// Contains information about `DeviceInfoItem`'s type (`category` or `info`) and
    /// the underlying information value in case the type is `info`
    /// - SeeAlso: ``DeviceInfoValueType``
    public let value: DeviceInfoValueType

    /// Optional child items for item type that aggregates a category of device information objects
    public let children: [DeviceInfoItem]?

    init(
        label: String,
        value: DeviceInfoValueType = .category,
        children: [DeviceInfoItem]? = nil
    ) {
        self.label = label
        self.value = value
        self.children = children
    }
}

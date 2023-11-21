@available(*, deprecated, message: "DiskSpaceInfo will be removed in a future library version")
public struct DiskSpaceInfo: Equatable, Encodable {
    public let freeDiskSpace: UInt64
    public let totalDiskSpace: UInt64
}

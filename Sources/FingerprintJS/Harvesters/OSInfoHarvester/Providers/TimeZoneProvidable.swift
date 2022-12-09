protocol TimeZoneInfoProvidable {
    var identifier: String { get }
}

extension TimeZone: TimeZoneInfoProvidable {}

import Foundation

protocol TimeZoneProvidable {
    var current: TimeZone { get }
}

struct TimeZoneProvider: TimeZoneProvidable {
    var current: TimeZone { .current }
}

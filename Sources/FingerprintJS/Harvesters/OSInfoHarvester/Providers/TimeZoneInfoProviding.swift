import Foundation

protocol TimeZoneInfoProviding {
    var identifier: String { get }
}

extension TimeZone: TimeZoneInfoProviding {}

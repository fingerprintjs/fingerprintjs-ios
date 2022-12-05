import Foundation

protocol LocaleInfoProvidable {
    var identifier: String { get }
}

extension Locale: LocaleInfoProvidable {}

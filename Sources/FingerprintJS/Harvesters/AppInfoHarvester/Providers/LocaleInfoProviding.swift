import Foundation

protocol LocaleInfoProviding {
    var identifier: String { get }
}

extension Locale: LocaleInfoProviding {}

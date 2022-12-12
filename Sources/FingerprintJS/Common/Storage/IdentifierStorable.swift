import Foundation

protocol IdentifierStorable {
    func storeIdentifier(_ identifier: UUID, for key: String)
    func loadIdentifier(for key: String) -> UUID?
}

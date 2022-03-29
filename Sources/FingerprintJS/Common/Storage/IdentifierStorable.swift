//
//  IdentifierStorable.swift
//  FingerprintJS
//
//  Created by Petr Palata on 09.03.2022.
//

import Foundation

protocol IdentifierStorable {
    func storeIdentifier(_ identifier: UUID, for key: String)
    func loadIdentifier(for key: String) -> UUID?
}

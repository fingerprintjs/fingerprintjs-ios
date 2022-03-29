//
//  SystemControlError.swift
//  FingerprintJS
//
//  Created by Petr Palata on 16.03.2022.
//

import Foundation

enum SystemControlError: Error {
    case wrongOutputType
    case genericError(errno: Int32)
}

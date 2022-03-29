//
//  CGSize+CustomStringConvertible.swift
//  FingerprintJS
//
//  Created by Petr Palata on 20.03.2022.
//

import CoreGraphics

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "\(self.width)x\(self.height)"
    }
}

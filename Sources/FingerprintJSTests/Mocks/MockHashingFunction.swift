//
//  MockHashingFunction.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 23.03.2022.
//
import Foundation

@testable import FingerprintJS

class MockFingerprintFunction: FingerprintFunction {
    var fakeHash: String = ""

    func fingerprint(data: Data) -> String {
        return fakeHash
    }
}

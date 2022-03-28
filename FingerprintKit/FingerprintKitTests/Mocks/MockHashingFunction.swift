//
//  MockHashingFunction.swift
//  FingerprintKitTests
//
//  Created by Petr Palata on 23.03.2022.
//

@testable import FingerprintKit

class MockFingerprintFunction: FingerprintFunction {
    var fakeHash: String = ""

    func fingerprint(data: Data) -> String {
        return fakeHash
    }
}

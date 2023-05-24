import XCTest

@testable import FingerprintJS

class SHA256HashingFunctionTests: XCTestCase {
    private var sut: SHA256HashingFunction!

    override func setUpWithError() throws {
        sut = SHA256HashingFunction()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    @available(iOS 13.0, tvOS 13.0, *)
    func testComputesSameHashForBothHashingVersions() {
        let data = Data(base64Encoded: "dGhpcyBpcyBmaW5nZXJwcmludA==")!

        let sha256cryptoKit = sut.computeSHA256CryptoKit(data)
        let sha256commonCrypto = sut.computeSHA256CommonCrypto(data)

        XCTAssertEqual(sha256cryptoKit, sha256commonCrypto)
    }

    func testFingerprintComputesCorrectHashFunction() {
        let data = Data(base64Encoded: "dGhpcyBpcyBmaW5nZXJwcmludA==")!

        let fingerprint = sut.fingerprint(data: data)

        XCTAssertEqual(fingerprint, "d7ffc906ba87c045110c78f34aad06f5259788d7f535b84cf0dd4cdcbf08a436")
    }
}

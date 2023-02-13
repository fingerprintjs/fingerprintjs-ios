import XCTest

@testable import FingerprintJS

final class FingerprintJSVersionTests: XCTestCase {
    func test_givenVersionOne_whenSince_thenReturnsAllVersions() {
        // given
        let fromVersion = FingerprintJSVersion.v1

        // when
        let versions = [FingerprintJSVersion].since(fromVersion)

        // then
        XCTAssertEqual(versions, .all)
    }

    func test_givenVersionTwo_whenSince_thenReturnsAllVersionsExceptOne() {
        // given
        let fromVersion = FingerprintJSVersion.v2

        // when
        let versions = [FingerprintJSVersion].since(fromVersion)

        // then
        XCTAssertEqual(versions, [.v2, .v3, .v4, .v5])
    }

    func test_whenAll_thenReturnsAllVersions() {
        // when
        let versions = [FingerprintJSVersion].all

        // then
        XCTAssertEqual(versions, [.v1, .v2, .v3, .v4, .v5])
    }

    func test_whenLatest_thenReturnsVersionFive() {
        // when
        let latest = FingerprintJSVersion.latest

        // then
        XCTAssertEqual(latest, .v5)
    }
}

import XCTest

@testable import FingerprintJS

#if os(iOS)
final class LocalAuthenticationInfoHarvesterTests: XCTestCase {

    private var sut: LocalAuthenticationInfoHarvester!

    override func setUp() {
        super.setUp()
        sut = .init(
            authenticationContextInfoProvider: AuthenticationContextInfoProvidingDummy()
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_givenConfigurationWithVersionFiveAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Passcode",
            "Biometrics",
            "Biometry type",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndOptimalStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Passcode",
            "Biometrics",
            "Biometry type",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Biometry type"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }
}
#endif

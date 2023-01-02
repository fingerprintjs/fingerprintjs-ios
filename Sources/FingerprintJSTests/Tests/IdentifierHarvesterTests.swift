import XCTest

@testable import FingerprintJS

final class IdentifierHarvesterTests: XCTestCase {
    private var sut: IdentifierHarvester!
    private var identifierStorableSpy: IdentifierStorableSpy!

    override func setUp() {
        super.setUp()
        identifierStorableSpy = .init()
        sut = .init(identifierStorableSpy, device: .current)
    }

    override func tearDown() {
        sut = nil
        identifierStorableSpy = nil
        super.tearDown()
    }

    func test_givenConfigurationWithVersionOneAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v1, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionOneAndOptimalStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v1, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionOneAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v1, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionTwoAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v2, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionTwoAndOptimalStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v2, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionTwoAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v2, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionThreeAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionThreeAndOptimalStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionThreeAndStableStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label) ?? []
        XCTAssertTrue(itemLabels.isEmpty)
    }

    func
        test_givenIdentifierMissingLegacyIdentifierPresent_whenVendorIdentifier_thenMigratesLegacyIdentifierToNewStorage()
    {
        // given
        let legacyIdentifier = UUID(uuidString: "a1084045-c9da-4e82-ae9b-8521379b0d07")!
        identifierStorableSpy.loadIdentifierReturnDictionary = [
            "vendorIdentifier": legacyIdentifier
        ]

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertEqual(
            identifierStorableSpy.storeIdentifierInputs,
            ["vendorIdentifierBackground": legacyIdentifier]
        )
        XCTAssertEqual(identifier, legacyIdentifier)
    }

    func test_givenBgIdentifierPresent_whenVendorIdentifier_thenReturnsBgIdentifier() {
        // given
        let bgIdentifier = UUID(uuidString: "a1084045-c9da-4e82-ae9b-8521379b0d07")!
        identifierStorableSpy.loadIdentifierReturnDictionary = ["vendorIdentifierBackground": bgIdentifier]

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertEqual(identifier, bgIdentifier)
    }
}

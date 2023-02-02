import XCTest

@testable import FingerprintJS

final class IdentifierHarvesterTests: XCTestCase {
    private var sut: IdentifierHarvester!
    private var identifierStorageSpy: IdentifierStorableSpy!
    private var vendorIdentifierProviderSpy: VendorIdentifierProvidingSpy!

    override func setUp() {
        super.setUp()
        identifierStorageSpy = .init()
        vendorIdentifierProviderSpy = .init()
        sut = .init(
            identifierStorage: identifierStorageSpy,
            vendorIdentifierProvider: vendorIdentifierProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        vendorIdentifierProviderSpy = nil
        identifierStorageSpy = nil
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

    func test_givenConfigurationWithVersionFourAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFourAndOptimalStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFourAndStableStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label) ?? []
        XCTAssertTrue(itemLabels.isEmpty)
    }

    func test_givenConfigurationWithVersionFiveAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Vendor identifier"
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
            "Vendor identifier"
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndStableStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .stable)

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
        identifierStorageSpy.loadIdentifierReturnDictionary = [
            "vendorIdentifier": legacyIdentifier
        ]

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertEqual(
            identifierStorageSpy.storeIdentifierInputs,
            ["id.vendor": legacyIdentifier]
        )
        XCTAssertEqual(identifier, legacyIdentifier)
    }

    func test_givenIdentifierPresent_whenVendorIdentifier_thenReturnsIdentifier() {
        // given
        let expectedIdentifier = UUID(uuidString: "a1084045-c9da-4e82-ae9b-8521379b0d07")!
        identifierStorageSpy.loadIdentifierReturnDictionary = ["id.vendor": expectedIdentifier]

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertEqual(identifier, expectedIdentifier)
    }

    func test_givenNoStoredIdentifiers_whenVendorIdentifier_thenStoresAndReturnsSystemVendorIdentifier() {
        // given
        let systemIdentifier = UUID(uuidString: "a1084045-c9da-4e82-ae9b-8521379b0d07")!
        vendorIdentifierProviderSpy.vendorIdentifierReturnValue = systemIdentifier

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertEqual(identifier, systemIdentifier)
        XCTAssertEqual(
            identifierStorageSpy.storeIdentifierInputs,
            ["id.vendor": systemIdentifier]
        )
    }

    func test_givenNoIdentifiers_whenVendorIdentifier_thenReturnsNil() {
        // given
        vendorIdentifierProviderSpy.vendorIdentifierReturnValue = nil
        identifierStorageSpy.loadIdentifierReturnDictionary = [:]

        // when
        let identifier = sut.vendorIdentifier

        // then
        XCTAssertNil(identifier)
        XCTAssertTrue(identifierStorageSpy.storeIdentifierInputs.isEmpty)
    }
}

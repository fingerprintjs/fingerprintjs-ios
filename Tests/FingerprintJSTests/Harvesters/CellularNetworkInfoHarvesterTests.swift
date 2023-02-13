import XCTest

@testable import FingerprintJS

#if os(iOS)
final class CellularNetworkInfoHarvesterTests: XCTestCase {
    private var cellularServiceInfoProviderSpy: CellularServiceInfoProvidingSpy!

    private var sut: CellularNetworkInfoHarvester!

    override func setUp() {
        super.setUp()
        cellularServiceInfoProviderSpy = .init()
        sut = .init(
            cellularServiceInfoProvider: cellularServiceInfoProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        cellularServiceInfoProviderSpy = nil
        super.tearDown()
    }

    func test_givenNoCelluarProviders_whenMobileCountryCodes_thenReturnsEmptyArray() {
        // given
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = []

        // when
        let mobileCountryCodes = sut.mobileCountryCodes

        // then
        XCTAssertTrue(mobileCountryCodes.isEmpty)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
    }

    func test_givenNoCelluarProviders_whenMobileNetworkCodes_thenReturnsEmptyArray() {
        // given
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = []

        // when
        let mobileNetworkCodes = sut.mobileNetworkCodes

        // then
        XCTAssertTrue(mobileNetworkCodes.isEmpty)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
    }

    func test_givenTwoCelluarProviders_whenMobileCountryCodes_thenReturnsArrayWithTwoElementsInAscendingOrder() {
        // given
        let firstProvider = CarrierInfoProvidingSpy(mobileCountryCode: "048")
        let secondProvider = CarrierInfoProvidingSpy(mobileCountryCode: "001")
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = [
            firstProvider,
            secondProvider,
        ]

        // when
        let mobileCountryCodes = sut.mobileCountryCodes

        // then
        XCTAssertEqual(["001", "048"], mobileCountryCodes)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
        XCTAssertEqual(1, firstProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(0, firstProvider.mobileNetworkCodeCallCount)
        XCTAssertEqual(1, secondProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(0, secondProvider.mobileNetworkCodeCallCount)
    }

    func test_givenTwoCelluarProviders_whenMobileNetworkCodes_thenReturnsArrayWithTwoElementsInAscendingOrder() {
        // given
        let firstProvider = CarrierInfoProvidingSpy(mobileNetworkCode: "06")
        let secondProvider = CarrierInfoProvidingSpy(mobileNetworkCode: "01")
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = [
            firstProvider,
            secondProvider,
        ]

        // when
        let mobileNetworkCodes = sut.mobileNetworkCodes

        // then
        XCTAssertEqual(["01", "06"], mobileNetworkCodes)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
        XCTAssertEqual(0, firstProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(1, firstProvider.mobileNetworkCodeCallCount)
        XCTAssertEqual(0, secondProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(1, secondProvider.mobileNetworkCodeCallCount)
    }

    func test_givenUnknownCellularProvider_whenMobileCountryCodes_thenReturnsEmptyArray() {
        // given
        let unknownProvider = CarrierInfoProvidingSpy()
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = [
            unknownProvider
        ]

        // when
        let mobileCountryCodes = sut.mobileCountryCodes

        // then
        XCTAssertTrue(mobileCountryCodes.isEmpty)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
        XCTAssertEqual(1, unknownProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(0, unknownProvider.mobileNetworkCodeCallCount)
    }

    func test_givenUnknownCellularProvider_whenMobileNetworkCodes_thenReturnsEmptyArray() {
        // given
        let unknownProvider = CarrierInfoProvidingSpy()
        cellularServiceInfoProviderSpy.cellularProvidersReturnValue = [
            unknownProvider
        ]

        // when
        let mobileNetworkCodes = sut.mobileNetworkCodes

        // then
        XCTAssertTrue(mobileNetworkCodes.isEmpty)
        XCTAssertEqual(1, cellularServiceInfoProviderSpy.cellularProvidersCallCount)
        XCTAssertEqual(0, unknownProvider.mobileCountryCodeCallCount)
        XCTAssertEqual(1, unknownProvider.mobileNetworkCodeCallCount)
    }

    func test_givenConfigurationWithVersionThreeAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Mobile country codes",
            "Mobile network codes",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionThreeAndOptimalStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label) ?? []
        XCTAssertTrue(itemLabels.isEmpty)
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
            "Mobile country codes",
            "Mobile network codes",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFourAndOptimalStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label) ?? []
        XCTAssertTrue(itemLabels.isEmpty)
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
            "Mobile country codes",
            "Mobile network codes",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndOptimalStabilityLevel_whenBuildTree_thenReturnsNoItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .optimal)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label) ?? []
        XCTAssertTrue(itemLabels.isEmpty)
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
}
#endif

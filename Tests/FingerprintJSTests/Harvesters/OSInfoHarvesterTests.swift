import XCTest

@testable import FingerprintJS

final class OSInfoHarvesterTests: XCTestCase {
    private var sut: OSInfoHarvester!

    private var systemControlMock: SystemControlMock!
    private var timeZoneInfoProviderSpy: TimeZoneInfoProvidingSpy!

    override func setUp() {
        super.setUp()
        systemControlMock = .init()
        timeZoneInfoProviderSpy = .init()
        sut = OSInfoHarvester(
            systemControl: systemControlMock,
            timeZoneInfoProvider: timeZoneInfoProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        systemControlMock = nil
        timeZoneInfoProviderSpy = nil
        super.tearDown()
    }

    func test_givenAmericaChicagoTimeZoneIdentifier_whenOSTimeZoneIdentifier_thenReturnsExpectedIdentifier() {
        // given
        let americaChicagoIdentifier = "America/Chicago"
        timeZoneInfoProviderSpy.identifierReturnValue = americaChicagoIdentifier

        // when
        let timeZoneIdentifier = sut.osTimeZoneIdentifier

        // then
        XCTAssertEqual(americaChicagoIdentifier, timeZoneIdentifier)
        XCTAssertEqual(1, timeZoneInfoProviderSpy.identifierCallCount)
    }

    func test_givenConfigurationWithVersionOneAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v1, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
            "Boot time",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
            "Boot time",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
            "Boot time",
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
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
            "Boot time",
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
}

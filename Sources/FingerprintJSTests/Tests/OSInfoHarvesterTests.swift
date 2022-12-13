import XCTest

@testable import FingerprintJS

final class OSInfoHarvesterTests: XCTestCase {
    private var sut: OSInfoHarvester!

    private var systemControlMock: SystemControlMock!
    private var timeZoneInfoProviderSpy: TimeZoneInfoProvidableSpy!

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

    // MARK: buildTree
    func testBuildTreeReturnsCorrectNumberOfItemsForVersionOne() {
        let config = Configuration(version: .v1)

        let tree = sut.buildTree(config)

        XCTAssertEqual(tree.children?.count, 4)
    }

    func testBuildTreeReturnsCorrectItemsForVersionOne() {
        let config = Configuration(version: .v1)
        let expectedLabels = [
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
        ]

        let tree = sut.buildTree(config)
        let labels = tree.children?.map { $0.label }

        XCTAssertEqual(expectedLabels, labels)
    }

    func testBuildTreeReturnsCorrectNumberOfItemsForVersionTwo() {
        // Subject to change when items are added/removed in version 2
        testBuildTreeReturnsCorrectItemsForVersionOne()
    }

    func testBuildTreeReturnsCorrectItemsForVersionTwo() {
        // Subject to change when items are added/removed in version 2
        testBuildTreeReturnsCorrectNumberOfItemsForVersionOne()
    }

    func test_givenConfigurationWithVersionThree_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map { $0.label }
        let expectedItemLabels = [
            "OS time zone identifier",
            "OS release",
            "OS type",
            "OS version",
            "Kernel version",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }
}

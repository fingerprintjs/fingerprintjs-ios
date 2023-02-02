import XCTest

@testable import FingerprintJS

final class AppInfoHarvesterTests: XCTestCase {
    private var localeInfoProviderSpy: LocaleInfoProvidingSpy!
    private var userInterfaceTraitsProviderSpy: UserInterfaceTraitsProvidingSpy!

    private var sut: AppInfoHarvester!

    override func setUp() {
        super.setUp()
        localeInfoProviderSpy = .init()
        userInterfaceTraitsProviderSpy = .init()
        sut = .init(
            localeInfoProvider: localeInfoProviderSpy,
            userInterfaceTraitsProvider: userInterfaceTraitsProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        userInterfaceTraitsProviderSpy = nil
        localeInfoProviderSpy = nil
        super.tearDown()
    }

    func test_givenEnUsLocale_whenLocaleIdentifier_thenReturnsExpectedLocaleIdentifier() {
        // given
        let enUsLocaleIdentifier = "en-US"
        localeInfoProviderSpy.identifierReturnValue = enUsLocaleIdentifier

        // when
        let localeIdentifier = sut.localeIdentifier

        // then
        XCTAssertEqual(enUsLocaleIdentifier, localeIdentifier)
        XCTAssertEqual(1, localeInfoProviderSpy.identifierCallCount)
    }

    func test_givenLightInterfaceStyle_whenUserInterfaceStyle_thenReturnsExpectedInterfaceStyle() {
        // given
        userInterfaceTraitsProviderSpy.userInterfaceStyleReturnValue = .light

        // when
        let interfaceStyle = sut.userInterfaceStyle

        // then
        XCTAssertEqual(.light, interfaceStyle)
        XCTAssertEqual(1, userInterfaceTraitsProviderSpy.userInterfaceStyleCallCount)
    }

    func test_givenDarkInterfaceStyle_whenUserInterfaceStyle_thenReturnsExpectedInterfaceStyle() {
        // given
        userInterfaceTraitsProviderSpy.userInterfaceStyleReturnValue = .dark

        // when
        let interfaceStyle = sut.userInterfaceStyle

        // then
        XCTAssertEqual(.dark, interfaceStyle)
        XCTAssertEqual(1, userInterfaceTraitsProviderSpy.userInterfaceStyleCallCount)
    }

    func test_givenUnspecifiedInterfaceStyle_whenUserInterfaceStyle_thenReturnsExpectedInterfaceStyle() {
        // given
        userInterfaceTraitsProviderSpy.userInterfaceStyleReturnValue = .unspecified

        // when
        let interfaceStyle = sut.userInterfaceStyle

        // then
        XCTAssertEqual(.undefined, interfaceStyle)
        XCTAssertEqual(1, userInterfaceTraitsProviderSpy.userInterfaceStyleCallCount)
    }

    func test_givenInstanceWithDefaultProviders_whenUserInterfaceStyle_thenReturnsExpectedInterfaceStyle() {
        // given
        sut = .init()

        // when
        let interfaceStyle = sut.userInterfaceStyle

        // then
        let expectedInterfaceStyle: UserInterfaceStyle
        if #available(iOS 13.0, tvOS 13.0, *) {
            expectedInterfaceStyle = .init(UITraitCollection.current.userInterfaceStyle)
        } else {
            expectedInterfaceStyle = .light
        }
        XCTAssertEqual(expectedInterfaceStyle, interfaceStyle)
    }

    func test_givenConfigurationWithVersionThreeAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Locale identifier",
            "User interface style",
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
            "Locale identifier",
            "User interface style",
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
            "Locale identifier",
            "User interface style",
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

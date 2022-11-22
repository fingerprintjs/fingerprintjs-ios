import XCTest

@testable import FingerprintJS

final class AppInfoHarvesterTests: XCTestCase {
    private var userInterfaceTraitsProviderSpy: UserInterfaceTraitsProvidableSpy!

    private var sut: AppInfoHarvester!

    override func setUp() {
        super.setUp()
        userInterfaceTraitsProviderSpy = .init()
        sut = .init(
            userInterfaceTraitsProvider: userInterfaceTraitsProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        userInterfaceTraitsProviderSpy = nil
        super.tearDown()
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
}

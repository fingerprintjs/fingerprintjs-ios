import XCTest

#if !COCOAPODS
@testable import SystemControl
#else
@testable import FingerprintJS
#endif

final class HardwareSubsystemTests: XCTestCase {
    private var systemControlValuesRetrieverSpy: SystemControlValuesRetrievingSpy!

    private var sut: HardwareSubsystem!

    override func setUp() {
        super.setUp()
        systemControlValuesRetrieverSpy = .init()
        sut = .init(systemControl: systemControlValuesRetrieverSpy)
    }

    override func tearDown() {
        sut = nil
        systemControlValuesRetrieverSpy = nil
        super.tearDown()
    }

    func test_givenModelWithNilSuffix_whenModelRetrieved_thenReturnsModelWihoutNilSuffix() {
        // given
        systemControlValuesRetrieverSpy.modelReturnValue = "DeviceModel\\u0000"

        // when
        let model = sut.model

        // then
        XCTAssertEqual(model, "DeviceModel")
    }

    func test_givenModelWithoutNilSuffix_whenModelRetrieved_thenReturnsModelWihoutNilSuffix() {
        // given
        systemControlValuesRetrieverSpy.modelReturnValue = "DeviceModel"

        // when
        let model = sut.model

        // then
        XCTAssertEqual(model, "DeviceModel")
    }
}

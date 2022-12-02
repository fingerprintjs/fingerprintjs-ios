//
//  OSInfoHarvesterTests.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 12.04.2022.
//

import XCTest

@testable import FingerprintJS

final class OSInfoHarvesterTests: XCTestCase {
    private var sut: OSInfoHarvester!

    private var systemControlMock: SystemControlMock!
    private var timeZoneProviderSpy: TimeZoneProvidableSpy!

    override func setUp() {
        super.setUp()
        systemControlMock = .init()
        timeZoneProviderSpy = .init()
        sut = OSInfoHarvester(
            systemControl: systemControlMock,
            timeZoneProvider: timeZoneProviderSpy
        )
    }

    override func tearDown() {
        sut = nil
        systemControlMock = nil
        timeZoneProviderSpy = nil
        super.tearDown()
    }

    func test_givenCentralEuropeanTimeZone_whenOSTimeZone_thenReturnsExpectedTimeZone() {
        // given
        let cet = TimeZone(secondsFromGMT: 3600)!
        timeZoneProviderSpy.currentReturnValue = cet

        // when
        let timeZone = sut.osTimeZone

        // then
        XCTAssertEqual(cet, timeZone)
        XCTAssertEqual(1, timeZoneProviderSpy.currentCallCount)
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
}

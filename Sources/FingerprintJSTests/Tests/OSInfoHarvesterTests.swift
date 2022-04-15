//
//  OSInfoHarvesterTests.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 12.04.2022.
//

import XCTest

@testable import FingerprintJS

class OSInfoHarvesterTests: XCTestCase {
    private var sut: OSInfoHarvester!
    private let systemControlMock = SystemControlMock()

    override func setUpWithError() throws {
        sut = OSInfoHarvester(systemControlMock)
    }

    override func tearDownWithError() throws {
        sut = nil
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

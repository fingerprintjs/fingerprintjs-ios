//
//  IdentifierHarvesterTests.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 12.04.2022.
//

import XCTest

@testable import FingerprintJS

class IdentifierHarvesterTests: XCTestCase {
    private var sut: IdentifierHarvester!

    override func setUpWithError() throws {
        sut = IdentifierHarvester()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: buildTree
    func testBuildTreeReturnsCorrectNumberOfItemsForVersionOne() {
        let config = Configuration(version: .v1)

        let tree = sut.buildTree(config)

        XCTAssertEqual(tree.children?.count, 1)
    }

    func testBuildTreeReturnsCorrectItemsForVersionOne() {
        let config = Configuration(version: .v1)
        let expectedLabels = [
            "Vendor identifier"
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

//
//  HardwareInfoHarvesterTests.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 08.04.2022.
//

import XCTest

@testable import FingerprintJS

final class HardwareInfoHarvesterTests: XCTestCase {
    private var sut: HardwareInfoHarvester!

    private var screenInfoProviderSpy: ScreenInfoProvidingSpy!
    private var mockDeviceModelProvider: DeviceModelProvidingMock!
    private var mockSystemControl: SystemControlMock!
    private var mockDocumentDirectoryAttributesProvider: DocumentsDirectoryAttributesProvidingMock!
    private var mockCpuInfoProvider: CPUInfoProvidingMock!

    override func setUp() {
        super.setUp()
        screenInfoProviderSpy = .init()
        mockDeviceModelProvider = .init()
        mockSystemControl = .init()
        mockDocumentDirectoryAttributesProvider = .init()
        mockCpuInfoProvider = .init()
        sut = HardwareInfoHarvester(
            mockDeviceModelProvider,
            screen: screenInfoProviderSpy,
            systemControl: mockSystemControl,
            fileManager: mockDocumentDirectoryAttributesProvider,
            processInfo: mockCpuInfoProvider
        )
    }

    override func tearDown() {
        sut = nil
        mockCpuInfoProvider = nil
        mockDocumentDirectoryAttributesProvider = nil
        mockSystemControl = nil
        mockDeviceModelProvider = nil
        screenInfoProviderSpy = nil
        super.tearDown()
    }

    func test_givenSuperRetinaDisplay_whenDisplayResolution_thenReturnsExpectedResolution() {
        // given
        let superRetinaBounds: CGRect = .init(x: .zero, y: .zero, width: 1170, height: 2532)
        screenInfoProviderSpy.nativeBoundsReturnValue = superRetinaBounds

        // when
        let displayResolution = sut.displayResolution

        // then
        let expectedResolution = superRetinaBounds.size
        XCTAssertEqual(expectedResolution, displayResolution)
        XCTAssertEqual(1, screenInfoProviderSpy.nativeBoundsCallCount)
        XCTAssertEqual(0, screenInfoProviderSpy.nativeScaleCallCount)
    }

    func test_givenSuperRetinaDisplay_whenDisplayScale_thenReturnsExpectedScale() {
        // given
        let superRetinaScale: CGFloat = 3.0
        screenInfoProviderSpy.nativeScaleReturnValue = superRetinaScale

        // when
        let displayScale = sut.displayScale

        // then
        XCTAssertEqual(superRetinaScale, displayScale)
        XCTAssertEqual(0, screenInfoProviderSpy.nativeBoundsCallCount)
        XCTAssertEqual(1, screenInfoProviderSpy.nativeScaleCallCount)
    }

    func testFreeDiskSpaceReturnsZeroIfDocumentsDirAttributesEmpty() {
        XCTAssertEqual(sut.freeDiskSpace, 0)
    }

    func testFreeDiskSpaceReturnsZeroIfDocumentsAttributesThrowsError() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributesError =
            DocumentsDirectoryError.documentsDirectoryNotFound
        XCTAssertEqual(sut.freeDiskSpace, 0)
    }

    func testFreeDiskSpaceReturnsZeroIfDocumentsAttributesPresentButThrowError() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemFreeSize: UInt64(100),
            .systemSize: UInt64(100),
        ]

        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributesError =
            DocumentsDirectoryError.documentsDirectoryNotFound

        XCTAssertEqual(sut.freeDiskSpace, 0)
    }

    func testFreeDiskSpaceReturnsCorrectValuesOnSuccess() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemFreeSize: UInt64(100),
            .systemSize: UInt64(100),
        ]

        XCTAssertEqual(sut.freeDiskSpace, 100)
    }

    func testFreeDiskSpaceReturnsZeroIfOtherValueMissing() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemFreeSize: UInt64(100)
        ]

        XCTAssertEqual(sut.freeDiskSpace, 0)
    }

    // MARK: totalDiskSpace
    func testTotalDiskSpaceReturnsZeroIfDocumentsDirAttributesEmpty() {
        XCTAssertEqual(sut.totalDiskSpace, 0)
    }

    func testTotalDiskSpaceReturnsZeroIfDocumentsAttributesThrowsError() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributesError =
            DocumentsDirectoryError.documentsDirectoryNotFound
        XCTAssertEqual(sut.totalDiskSpace, 0)
    }

    func testTotalDiskSpaceReturnsZeroIfDocumentsAttributesPresentButThrowError() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemFreeSize: UInt64(100),
            .systemSize: UInt64(100),
        ]

        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributesError =
            DocumentsDirectoryError.documentsDirectoryNotFound

        XCTAssertEqual(sut.totalDiskSpace, 0)
    }

    func testTotalDiskSpaceReturnsCorrectValuesOnSuccess() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemFreeSize: UInt64(100),
            .systemSize: UInt64(100),
        ]

        XCTAssertEqual(sut.totalDiskSpace, 100)
    }

    func testTotalDiskSpaceReturnZeroIfOneValueMissing() {
        mockDocumentDirectoryAttributesProvider.mockDocumentsDirectoryAttributes = [
            .systemSize: UInt64(100)
        ]

        XCTAssertEqual(sut.totalDiskSpace, 0)
    }

    // MARK - buildTree
    func testBuildTreeReturnsCorrectNumberOfItemsForVersionOne() {
        let config = Configuration(version: .v1)

        let tree = sut.buildTree(config)

        XCTAssertEqual(tree.children?.count, 5)
    }

    func testBuildTreeReturnsCorrectItemsForVersionOne() {
        let config = Configuration(version: .v1)
        let versionOneLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
        ]

        let tree = sut.buildTree(config)
        let itemLabels = tree.children?.map { $0.label }

        XCTAssertEqual(itemLabels, versionOneLabels)
    }

    func testBuildTreeReturnsCorrectNumberOfItemsForVersionTwo() {
        let config = Configuration(version: .v2)

        let tree = sut.buildTree(config)

        XCTAssertEqual(tree.children?.count, 7)
    }

    func testBuildTreeReturnsCorrectItemsForVersionTwo() {
        let config = Configuration(version: .v2)
        let versionTwoLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
        ]

        let tree = sut.buildTree(config)
        let itemLabels = tree.children?.map { $0.label }

        XCTAssertEqual(itemLabels, versionTwoLabels)
    }
}

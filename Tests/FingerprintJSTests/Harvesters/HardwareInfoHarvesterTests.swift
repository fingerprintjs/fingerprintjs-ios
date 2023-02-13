import XCTest

@testable import FingerprintJS

final class HardwareInfoHarvesterTests: XCTestCase {
    private var sut: HardwareInfoHarvester!

    private var screenInfoProviderSpy: ScreenInfoProvidingSpy!
    private var deviceIdentificationInfoProviderSpy: DeviceIdentificationInfoProvidingSpy!
    private var mockSystemControl: SystemControlMock!
    private var mockDocumentDirectoryAttributesProvider: DocumentsDirectoryAttributesProvidingMock!
    private var mockCpuInfoProvider: CPUInfoProvidingMock!

    override func setUp() {
        super.setUp()
        screenInfoProviderSpy = .init()
        deviceIdentificationInfoProviderSpy = .init()
        mockSystemControl = .init()
        mockDocumentDirectoryAttributesProvider = .init()
        mockCpuInfoProvider = .init()
        sut = HardwareInfoHarvester(
            device: deviceIdentificationInfoProviderSpy,
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
        deviceIdentificationInfoProviderSpy = nil
        screenInfoProviderSpy = nil
        super.tearDown()
    }

    func test_givenUserAssignedDeviceName_whenDeviceName_thenReturnsExpectedName() {
        // given
        let customDeviceName = "My iPhone"
        deviceIdentificationInfoProviderSpy.userAssignedNameReturnValue = customDeviceName

        // when
        let deviceName = sut.deviceName

        // then
        XCTAssertEqual(customDeviceName, deviceName)
        XCTAssertEqual(0, deviceIdentificationInfoProviderSpy.modelCallCount)
        XCTAssertEqual(1, deviceIdentificationInfoProviderSpy.userAssignedNameCallCount)
    }

    func test_givenIPhoneModelString_whenDeviceType_thenReturnsExpectedTypeString() {
        // given
        let iPhoneModelString = "iPhone"
        deviceIdentificationInfoProviderSpy.modelReturnValue = iPhoneModelString

        // when
        let deviceType = sut.deviceType

        // then
        XCTAssertEqual(iPhoneModelString, deviceType)
        XCTAssertEqual(1, deviceIdentificationInfoProviderSpy.modelCallCount)
        XCTAssertEqual(0, deviceIdentificationInfoProviderSpy.userAssignedNameCallCount)
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

    func test_givenConfigurationWithVersionOneAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v1, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
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
            "Device name",
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionThreeAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v3, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFourAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device name",
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
            "Device hostname",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFourAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v4, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndUniqueStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .unique)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device name",
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Free disk space (B)",
            "Total disk space (B)",
            "Device hostname",
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
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }

    func test_givenConfigurationWithVersionFiveAndStableStabilityLevel_whenBuildTree_thenReturnsExpectedItems() {
        // given
        let config = Configuration(version: .v5, stabilityLevel: .stable)

        // when
        let itemsTree = sut.buildTree(config)

        // then
        let itemLabels = itemsTree.children?.map(\.label)
        let expectedItemLabels = [
            "Device type",
            "Device model",
            "Display resolution",
            "Display scale",
            "Physical memory",
            "Processor count",
            "Total disk space (B)",
        ]
        XCTAssertEqual(expectedItemLabels, itemLabels)
    }
}

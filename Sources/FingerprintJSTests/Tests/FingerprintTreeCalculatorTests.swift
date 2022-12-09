import XCTest

@testable import FingerprintJS

class FingerprintTreeCalculatorTests: XCTestCase {
    var sut: FingerprintTreeCalculator!
    var fingerprintFunction = MockFingerprintFunction()

    override func setUpWithError() throws {
        sut = FingerprintTreeCalculator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCalculateFingeprintReturnsCorrectValueForSingleInfoNode() {
        let singleNode = DeviceInfoItem(label: "Test", value: .info("Test"), children: nil)
        fingerprintFunction.fakeHash = "test fingerprint"

        let result = sut.calculateFingerprints(from: singleNode, hashFunction: fingerprintFunction)

        XCTAssertEqual(result.fingerprint, "test fingerprint")
    }

    func testCalculateFingerprintReturnsCompoundValueForNodeWithChildren() {
        let tree = DeviceInfoItem(
            label: "Test", value: .category,
            children: [
                DeviceInfoItem(label: "child1", value: .info("childValue1"), children: nil),
                DeviceInfoItem(label: "child2", value: .info("childValue2"), children: nil),
            ])

        fingerprintFunction.fakeHash = "test compound fingerprint"

        let result = sut.calculateFingerprints(from: tree, hashFunction: fingerprintFunction)

        XCTAssertEqual(result.fingerprint, "test compound fingerprint")
    }

    func testCalculateFingerprintComputesFingerprintsForChildNodes() {
        let tree = DeviceInfoItem(
            label: "Test", value: .category,
            children: [
                DeviceInfoItem(label: "child1", value: .info("childValue1"), children: nil),
                DeviceInfoItem(label: "child2", value: .info("childValue2"), children: nil),
            ])
        fingerprintFunction.fakeHash = "test fingerprint"

        let result = sut.calculateFingerprints(from: tree, hashFunction: fingerprintFunction)

        XCTAssertEqual(result.children?.count, 2)
        result.children?.forEach { XCTAssertEqual($0.fingerprint, fingerprintFunction.fakeHash) }
    }
}

import XCTest

@testable import FingerprintJS

final class DumpAllValuesTests: XCTestCase {
    override func setUp() {

    }

    func test1() {
        let systemControl = SystemControl()
        print(systemControl.dumpAllNames().joined(separator: "\n"))
        // print(systemControl.dumpAllANames().joined(separator: "\n"))
        print(systemControl.kernelVersion)

        let boottime = SystemControl().boottime
        print(boottime)
    }
}

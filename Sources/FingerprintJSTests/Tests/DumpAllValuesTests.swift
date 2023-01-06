import XCTest

@testable import FingerprintJS

final class DumpAllValuesTests: XCTestCase {
    override func setUp() {

    }

    func test1() {
        let systemControl = SystemControl()
        let tcp: tcpstat = try! systemControl.getSystemValue(.custom(Network.TCPStats().flags))
        print(systemControl.dumpAllNames().joined(separator: "\n"))
        // print(systemControl.dumpAllANames().joined(separator: "\n"))
        print(systemControl.kernelVersion)

        let boottime = SystemControl().boottime
        print(boottime)
        print(tcp)
    }
}

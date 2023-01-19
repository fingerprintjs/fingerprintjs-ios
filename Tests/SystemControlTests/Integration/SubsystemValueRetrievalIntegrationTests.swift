import XCTest

#if !COCOAPODS
@testable import SystemControl
#else
@testable import FingerprintJS
#endif

final class SubsystemValueRetrievalIntegrationTests: XCTestCase {
    func test_givenKernelSubsystem_whenValuesGetRetrieved_thenNoCrashesHappen() {
        // given
        let sut = KernelSubsystem()

        // when
        _ = sut.bootTime
        _ = sut.hostname
        _ = sut.osRelease
        _ = sut.osType
        _ = sut.osVersion
        _ = sut.kernelVersion
        _ = sut.osBuild

        // then
        // passes without crash
    }

    func test_givenHardwareSubsystem_whenValuesGetRetrieved_thenNoCrashesHappen() {
        // given
        let sut = HardwareSubsystem()

        // when
        _ = sut.model
        _ = sut.machine
        _ = sut.cpuCount
        _ = sut.cpuFrequency
        _ = sut.physicalMemory
        _ = sut.memorySize

        // then
        // passes without crash
    }

    func test_givenVirtualMemorySubsystem_whenValuesGetRetrieved_thenNoCrashesHappen() {
        // given
        let sut = VirtualMemorySubsystem()

        // when
        _ = sut.vmloadavg

        // then
        // passes without crash
    }
}

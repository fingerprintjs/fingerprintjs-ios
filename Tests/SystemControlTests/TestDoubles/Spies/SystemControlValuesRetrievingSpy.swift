import Foundation

#if !COCOAPODS
@testable import SystemControl
#else
@testable import FingerprintJS
#endif

final class SystemControlValuesRetrievingSpy: SystemControlValuesRetrieving {

    var modelReturnValue: String?
    var machineReturnValue: String?
    var memorySizeReturnValue: Int64?
    var physicalMemoryReturnValue: Int32?
    var cpuCountReturnValue: Int32?
    var cpuFrequencyReturnValue: Int32?

    private(set) var getSystemValueCallCount: Int = .zero

    func getSystemValue<T: SystemControlValueDefining>(_ definition: T) throws -> T.ValueType {
        getSystemValueCallCount += 1
        let sysctlFlags = definition.flags
        if sysctlFlags.contains(HW_MODEL) {
            return modelReturnValue as! T.ValueType
        } else if sysctlFlags.contains(HW_MACHINE) {
            return machineReturnValue as! T.ValueType
        } else if sysctlFlags.contains(HW_MEMSIZE) {
            return memorySizeReturnValue as! T.ValueType
        } else if sysctlFlags.contains(HW_PHYSMEM) {
            return physicalMemoryReturnValue as! T.ValueType
        } else if sysctlFlags.contains(HW_NCPU) {
            return cpuCountReturnValue as! T.ValueType
        } else if sysctlFlags.contains(HW_CPU_FREQ) {
            return cpuFrequencyReturnValue as! T.ValueType
        } else {
            fatalError("Unknown sysctl flags: \(sysctlFlags)")
        }
    }
}

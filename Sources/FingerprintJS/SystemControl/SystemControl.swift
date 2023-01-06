import Foundation

protocol SystemControlValuesProviding {
    var hardwareModel: String? { get }
    var hardwareMachine: String? { get }
    var osRelease: String? { get }
    var osType: String? { get }
    var osVersion: String? { get }
    var kernelVersion: String? { get }
    var osBuild: Int32? { get }
    var memorySize: Int64? { get }
    var physicalMemory: Int32? { get }
    var cpuCount: Int32? { get }
    var cpuFrequency: Int32? { get }
    var boottime: Date? { get }
}

public class SystemControl {
    public init() {}

    // Get a system value through a sysctl call
    func getSystemValue<T>(_ flag: SystemControlFlag) throws -> T {
        var size = 0

        var sysctlFlags = flag.sysctlFlags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        if errno == ERR_SUCCESS {
            let valueMemory = UnsafeMutableRawPointer.allocate(
                byteCount: size,
                alignment: MemoryLayout<T>.alignment
            )
            defer {
                valueMemory.deallocate()
            }

            errno = sysctl(&sysctlFlags, flagCount, valueMemory, &size, nil, 0)
            if errno == ERR_SUCCESS {
                return valueMemory.load(as: T.self)
            } else {
                throw SystemControlError.genericError(errno: errno)
            }
        } else {
            throw SystemControlError.genericError(errno: errno)
        }
    }

    public func getSystemString(_ flag: SystemControlFlag) throws -> String {
        var size = 0

        var sysctlFlags = flag.sysctlFlags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        if errno == ERR_SUCCESS {
            var cString = [CChar](repeating: 0, count: size)
            errno = sysctl(&sysctlFlags, flagCount, &cString, &size, nil, 0)
            if errno == ERR_SUCCESS {
                return String(cString: &cString)
            } else {
                throw SystemControlError.genericError(errno: errno)
            }
        } else {
            throw SystemControlError.genericError(errno: errno)
        }
    }

    public func getSystemValue<T: Subsystem>(_ subsystem: T) throws -> T.ValueType? {
        var size = 0

        var sysctlFlags = subsystem.flags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        if errno == ERR_SUCCESS {
            return try T.ValueType.withMemoryInput(of: size) { valuePtr in
                var rr = valuePtr
                errno = sysctl(&sysctlFlags, flagCount, &rr, &size, nil, 0)
                if errno == ERR_SUCCESS {
                    return T.ValueType.loadValue(&rr, bytes: size)
                } else {
                    throw SystemControlError.genericError(errno: errno)
                }
            }
        } else {
            throw SystemControlError.genericError(errno: errno)
        }
    }
}

extension SystemControl: SystemControlValuesProviding {
    var hardwareModel: String? {
        return try? getSystemString(.hardwareModel)
    }

    var hardwareMachine: String? {
        return try? getSystemString(.hardwareMachine)
    }

    var osRelease: String? {
        return try? getSystemString(.osRelease)
    }

    var osType: String? {
        return try? getSystemString(.osType)
    }

    var osVersion: String? {
        return try? getSystemString(.osVersion)
    }

    var kernelVersion: String? {
        return try? getSystemString(.kernelVersion)
    }

    var osBuild: Int32? {
        return try? getSystemValue(.osBuild)
    }

    var memorySize: Int64? {
        return try? getSystemValue(.memSize)
    }

    var physicalMemory: Int32? {
        return try? getSystemValue(.physicalMemory)
    }

    var cpuCount: Int32? {
        return try? getSystemValue(.cpuCount)
    }

    var cpuFrequency: Int32? {
        return try? getSystemValue(.cpuFrequency)
    }

    var boottime: Date? {
        guard let boottime: timeval = try? getSystemValue(.boottime) else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(boottime.tv_sec))
    }
}

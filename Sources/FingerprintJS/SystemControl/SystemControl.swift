//
//  SystemControl.swift
//  FingerprintJS
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

class SystemControl {
    // Get a system value through a sysctl call
    private func getSystemValue<T: DataConvertible>(_ flag: SystemControlFlag) throws -> T {
        var size = 0

        var sysctlFlags = flag.sysctlFlags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        if errno == ERR_SUCCESS {
            let valueMemory = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 1)
            defer {
                valueMemory.deallocate()
            }

            errno = sysctl(&sysctlFlags, flagCount, valueMemory, &size, nil, 0)
            if errno == ERR_SUCCESS {
                let data = Data(bytesNoCopy: valueMemory, count: size, deallocator: .none)
                return T.from(data)
            } else {
                throw SystemControlError.genericError(errno: errno)
            }
        } else {
            throw SystemControlError.genericError(errno: errno)
        }
    }
}

extension SystemControl {
    var hardwareModel: String? {
        return try? getSystemValue(.hardwareModel)
    }

    var hardwareMachine: String? {
        return try? getSystemValue(.hardwareMachine)
    }

    var osRelease: String? {
        return try? getSystemValue(.osRelease)
    }

    var osType: String? {
        return try? getSystemValue(.osType)
    }

    var osVersion: String? {
        return try? getSystemValue(.osVersion)
    }

    var kernelVersion: String? {
        return try? getSystemValue(.kernelVersion)
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
}

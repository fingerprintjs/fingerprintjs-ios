//
//  SystemControl.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

enum SystemControlError: Error {
    case wrongOutputType
    case genericError(errno: Int32)
}

protocol DataConvertible {
    static func from(_ data: Data) -> Self
}

extension String: DataConvertible {
    static func from(_ data: Data) -> String {
        return String(data: data, encoding: .utf8) ?? "Undefined"
    }
}

extension Int32: DataConvertible {
    static func from(_ data: Data) -> Int32 {
        return data.withUnsafeBytes { ptr in
            return ptr.load(as: Int32.self)
        }
    }
}

extension Int64: DataConvertible {
    static func from(_ data: Data) -> Int64 {
        return data.withUnsafeBytes { ptr in
            return ptr.load(as: Int64.self)
        }
    }
}

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
            if errno == 0 {
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
    public var hardwareModel: String? {
        return try? getSystemValue(.hardwareModel)
    }
    
    public var hardwareMachine: String? {
        return try? getSystemValue(.hardwareMachine)
    }
    
    public var osRelease: String? {
        return try? getSystemValue(.osRelease)
    }
    
    public var osType: String? {
        return try? getSystemValue(.osType)
    }
    
    public var osVersion: String? {
        return try? getSystemValue(.osVersion)
    }
    
    public var kernelVersion: String? {
        return try? getSystemValue(.kernelVersion)
    }
    
    public var osBuild: Int32? {
        return try? getSystemValue(.osBuild)
    }
    
    public var memorySize: Int64? {
        return try? getSystemValue(.memSize)
    }
    
    public var physicalMemory: Int32? {
        return try? getSystemValue(.physicalMemory)
    }
    
    public var cpuCount: Int32? {
        return try? getSystemValue(.cpuCount)
    }
    
    public var cpuFrequency: Int32? {
        return try? getSystemValue(.cpuFrequency)
    }
}

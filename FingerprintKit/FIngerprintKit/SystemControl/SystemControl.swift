//
//  SystemControl.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

private enum SystemControlFlag {
    case hardwareModel
    case hardwareMachine
    
    var sysctlFlags: [Int32] {
        switch self {
        case .hardwareMachine:
            return [CTL_HW, HW_MACHINE]
        case .hardwareModel:
            return [CTL_HW, HW_MODEL]
        }
    }
}

enum SystemControlError: Error {
    case wrongOutputType
    case genericError(errno: Int32)
}

class SystemControl {
    // Get a system value through a sysctl call
    private func getSystemValue<T: Sequence>(_ flag: SystemControlFlag) throws -> T {
        var size = 0
        
        var sysctlFlags = flag.sysctlFlags
        let flagCount = u_int(sysctlFlags.count)
        
        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        if errno == ERR_SUCCESS {
            let valueMemory = UnsafeMutableBufferPointer<T.Element>.allocate(capacity: size)
            defer {
                valueMemory.deallocate()
            }
            
            errno = sysctl(&sysctlFlags, flagCount, valueMemory.baseAddress, &size, nil, 0)
            if errno == 0 {
                guard let value = Array(valueMemory) as? T else {
                    throw SystemControlError.wrongOutputType
                }
                return value
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
        guard let model: [CChar] = try? getSystemValue(.hardwareModel) else {
            return nil
        }
        return String(cString: model)
    }
    
    public var hardwareMachine: String? {
        guard let machine: [CChar] = try? getSystemValue(.hardwareMachine) else {
            return nil
        }
        return String(cString: machine)
    }
}


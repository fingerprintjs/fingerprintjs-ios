//
//  SystemControlFlag.swift
//  FingerprintKit
//
//  Created by Petr Palata on 08.03.2022.
//

import Foundation

enum SystemControlFlag {
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


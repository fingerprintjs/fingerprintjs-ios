//
//  DeviceInfoViewModel.swift
//  DemoApp
//
//  Created by Petr Palata on 13.03.2022.
//

import SwiftUI
import FingerprintKit

class DeviceInfoViewModel: ObservableObject {
    @Published var infoTree: DeviceInfoItem?
    
    let fingerprinter: Fingerprinter = FingerprinterFactory.getInstance()
    
    func loadTree() async {
        infoTree = await fingerprinter.getFingerprintTree()
    }
}

extension DeviceInfoItem: Identifiable {
    public var id: String {
        return fingerprint ?? UUID().uuidString
    }
}

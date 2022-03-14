//
//  DeviceInfoViewModel.swift
//  DemoApp
//
//  Created by Petr Palata on 13.03.2022.
//

import SwiftUI
import FingerprintKit

class DeviceInfoViewModel: ObservableObject {
    @Published var infoCategories: [DeviceInfoCategory]
    
    let deviceInfoModel: DeviceInfoProvidable
    
    init(_ deviceInfoModel: DeviceInfoProvidable) {
        self.deviceInfoModel = deviceInfoModel
        self.infoCategories = deviceInfoModel.getDeviceInfo()
    }
}

extension DeviceInfoCategory: Identifiable {
    public var id: String {
        return label
    }
}

extension DeviceInfoItem: Identifiable {
    public var id: String {
        return label
    }
}

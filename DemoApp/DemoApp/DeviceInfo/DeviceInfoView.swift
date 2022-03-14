//
//  DeviceInfoView.swift
//  DemoApp
//
//  Created by Petr Palata on 13.03.2022.
//

import SwiftUI
import Combine
import FingerprintKit

struct DeviceInfoView: View {
    @ObservedObject var viewModel: DeviceInfoViewModel = DeviceInfoViewModel(DeviceInfo())
    
    var body: some View {
        ForEach(viewModel.infoCategories, id: \.id) { category in
            CollapsibleCard(category.label) {
                ForEach(category.items, id: \.id) {
                    DeviceInfoItemView(label: $0.label, value: $0.value)
                }
            }
        }
    }
}

struct DeviceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView()
    }
}


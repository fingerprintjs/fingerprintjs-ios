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
    @ObservedObject var viewModel: DeviceInfoViewModel = DeviceInfoViewModel()
    
    var body: some View {
        VStack {
            if let tree = viewModel.infoTree {
                InfoTreeView(tree: tree)
            }
        }.onAppear {
            Task.init {
                await viewModel.loadTree()
            }
        }
    }
}

struct DeviceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DeviceInfoView()
        }
    }
}

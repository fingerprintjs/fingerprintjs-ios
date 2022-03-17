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
        if #available(iOS 15.0, *) {
        VStack {
            if let tree = viewModel.infoTree {
                InfoTreeView(tree: tree)
                Text("Tree: \(tree.description) \(tree.children?.count ?? 0)")
            }
        }.task {
            async {
                await viewModel.loadTree()
            }
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

struct InfoTreeView: View {
    let tree: DeviceInfoItem
    
    var body: some View {
        Text(tree.fingerprint!)
    }
}

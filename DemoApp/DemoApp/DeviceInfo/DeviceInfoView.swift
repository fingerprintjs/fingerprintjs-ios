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

struct InfoTreeView: View {
    let tree: DeviceInfoItem
    
    var body: some View {
        CollapsibleCard("Device Fingerprint", subtitle: tree.fingerprint) {}
        if let children = tree.children {
            ForEach(children, id: \.fingerprint) { child in
                CollapsibleCard(child.label, subtitle: child.fingerprint) {
                    if let items = child.children {
                        VStack {
                            ForEach(items) { item in
                                DeviceInfoItemView(label: item.label, value: item.value)
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    }
                }
            }
        }
    }
}

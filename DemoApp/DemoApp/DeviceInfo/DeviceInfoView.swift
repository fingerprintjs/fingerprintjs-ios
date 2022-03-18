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
    let tree: FingerprintTree
    
    var body: some View {
        VStack {
            Text("Device Fingerprint")
            Text(tree.fingerprint)
        }
        if let children = tree.children {
            ForEach(children, id: \.fingerprint) { child in
                CollapsibleCard(child.info.label, subtitle: child.fingerprint) {
                    if let items = child.children {
                        VStack {
                            ForEach(items) { item in
                                if case let .info(value) = item.info.value {
                                    DeviceInfoItemView(label: item.info.label, value: value)
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    }
                }
            }
        }
    }
}

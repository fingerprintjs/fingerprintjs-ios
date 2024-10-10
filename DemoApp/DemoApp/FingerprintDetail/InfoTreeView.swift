//
//  InfoTreeView.swift
//  DemoApp
//
//  Created by Petr Palata on 20.03.2022.
//

import FingerprintJS
import SwiftUI

struct InfoTreeView: View {
    let tree: FingerprintTree

    var body: some View {
        VStack {
            if let children = tree.children {
                ForEach(children) { child in
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
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

extension FingerprintTree: Swift.Identifiable {
    public var id: String {
        return fingerprint + info.label
    }
}

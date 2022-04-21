//
//  FingerprintDetailView.swift
//  DemoApp
//
//  Created by Petr Palata on 13.03.2022.
//

import SwiftUI
import Combine
import FingerprintJS

struct FingerprintDetailView: View {
    let fingerprintTree: FingerprintTree
    let rawInfo: String?
    
    var body: some View {
        ScrollView {
            Text("The fingerprint was computed from the categories listed below. Each item in the list represents a single signal that is then aggregated into a single value describing the current device.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            
            InfoTreeView(tree: fingerprintTree)
            if let info = rawInfo {
                CollapsibleCard("Raw JSON") {
                    Text(info)
                }
            }
            Spacer()
        }
        .navigationTitle("Details")
    }
}

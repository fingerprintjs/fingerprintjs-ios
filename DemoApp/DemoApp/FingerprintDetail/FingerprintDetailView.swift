//
//  FingerprintDetailView.swift
//  DemoApp
//
//  Created by Petr Palata on 13.03.2022.
//

import SwiftUI
import Combine
import FingerprintKit

struct FingerprintDetailView: View {
    let fingerprintTree: FingerprintTree
    
    var body: some View {
        ScrollView {
            Text("The fingerprint was computed from the categories listed below. Each item in the list represents a single signal that is then aggregated into a single value describing the current device.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            
            InfoTreeView(tree: fingerprintTree)
            Spacer()
        }
        .navigationTitle("Details")
    }
}

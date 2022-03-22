//
//  FingerprintView.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import SwiftUI
import FingerprintKit

struct FingerprintView: View {
    let fingerprintTree: FingerprintTree
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Device Fingerprint").font(.system(size: 25))
            Divider()
            Text(fingerprintTree.fingerprint)
                .fontWeight(.medium)
                .foregroundColor(Color.fpOrange)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
    }
}

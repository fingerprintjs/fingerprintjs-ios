//
//  FingerprintView.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import FingerprintJS
import SwiftUI

struct FingerprintView: View {
    let fingerprintTree: FingerprintTree

    var body: some View {
        VStack(spacing: 16) {
            Text("Device Fingerprint").font(.system(size: 25))
            Divider()
            Text(fingerprintTree.fingerprint)
                .fontWeight(.medium)
                .foregroundColor(Color.accentColor)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 2, y: 2)
    }
}

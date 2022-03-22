//
//  FingerprintGeneratorView.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import SwiftUI
import FingerprintKit

struct FingerprintGeneratorView: View {
    @ObservedObject var viewModel: FingerprintGeneratorViewModel = FingerprintGeneratorViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 16) {
                VStack {
                    HStack(alignment: .center) {
                        Image("fingerprint")
                        Text("FingerprintJS").fontWeight(.bold)
                            .font(.system(size: 30))
                    }
                    
                    Text("Generate your unique device fingerprint")
                        .foregroundColor(.gray)
                }
                .padding()
                
                Button("Get Device Fingerprint", action: computeFingerprint)
                    .padding()
                    .background(Color.fpOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundColor(.white)
                
                if viewModel.loading {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Color.fpOrange)
                        )
                        .scaleEffect(1.3)
                        .padding(EdgeInsets(top: 48, leading: 0, bottom: 0, trailing: 0))
                } else if let tree = viewModel.fingerprintTree {
                    VStack(alignment: .center, spacing: 20) {
                        FingerprintView(fingerprintTree: tree)
                        NavigationLink(destination: FingerprintDetailView(fingerprintTree: tree)) {
                            Text("Show details")
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                }
            })
            .navigationBarHidden(false)
        }
    }
    
    private func computeFingerprint() {
        Task.init {
            await viewModel.generateTree()
        }
    }
}

struct FingerprintGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        FingerprintGeneratorView()
    }
}

extension Color {
    static var fpOrange: Self {
        return Self("FingerprintJS Orange")
    }
}

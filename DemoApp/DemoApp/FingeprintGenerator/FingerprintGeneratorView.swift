//
//  FingerprintGeneratorView.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import FingerprintJS
import SwiftUI

struct FingerprintGeneratorView: View {
    @ObservedObject var viewModel: FingerprintGeneratorViewModel = FingerprintGeneratorViewModel()
    @State var showPrivacyPolicy: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack {
                    HStack(alignment: .center) {
                        Image("FingerprintImage")
                        Text("FingerprintJS")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                    }

                    Text("Generate your unique device fingerprint")
                        .foregroundColor(.gray)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: viewModel.state.largeMargin ? 100 : 0,
                                trailing: 0
                            )
                        )
                }
                .padding()

                switch viewModel.state {
                case .notGenerated:
                    VStack {
                        Button("Get Device Fingerprint", action: computeFingerprint)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.white)
                    }.padding()

                case .generating:
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Color.accentColor)
                        )
                        .scaleEffect(1.3)
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))

                case .fingerprintReady(let tree):
                    VStack(alignment: .center, spacing: 20) {
                        FingerprintView(fingerprintTree: tree)
                        let detailView = FingerprintDetailView(
                            fingerprintTree: tree  // ,
                                // rawInfo: viewModel.deviceInfo.debugDescription
                        )

                        NavigationLink(destination: detailView) {
                            HStack {
                                Text("Show details")
                                Image(systemName: "arrow.right")
                            }.padding(Edge.Set(.leading), 18)
                        }

                        Button("Generate Again", action: computeFingerprint)
                            .padding()
                            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                Spacer()
                PrivacyPolicyView(showPrivacyPolicy: $showPrivacyPolicy)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(false)
        }.navigationViewStyle(StackNavigationViewStyle())
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

extension FingerprintGeneratorState {
    var largeMargin: Bool {
        switch self {
        case .notGenerated, .generating:
            return true
        case .fingerprintReady:
            return false
        }
    }
}

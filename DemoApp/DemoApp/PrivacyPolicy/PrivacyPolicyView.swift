//
//  PrivacyPolicyView.swift
//  DemoApp
//
//  Created by Petr Palata on 23.05.2022.
//

import SwiftUI

struct PrivacyPolicyView: View {
    private let privacyPolicyURL = URL(string: "https://raw.githubusercontent.com/fingerprintjs/fingerprintjs-ios/main/DemoApp/TERMS.md")
    
    @Binding var showPrivacyPolicy: Bool
    
    var body: some View {
        if let privacyPolicyURL = privacyPolicyURL {
            NavigationLink("Privacy Policy", destination: {
                WebView(request: URLRequest(url: privacyPolicyURL))
                    .navigationTitle("Privacy Policy")
            })
            .padding()
        } else {
            Text("Invalid Privacy Policy URL")
        }
    }
}

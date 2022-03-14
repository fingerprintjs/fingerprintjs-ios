//
//  DemoApp.swift
//  DemoApp
//
//  Created by Petr Palata on 11.03.2022.
//

import SwiftUI
import FingerprintKit

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView {
                DeviceInfoView().padding()
            }
        }
    }
}

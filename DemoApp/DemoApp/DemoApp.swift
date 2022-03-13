//
//  DemoApp.swift
//  DemoApp
//
//  Created by Petr Palata on 11.03.2022.
//

import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            CollapsibleCard("Device ID") {
                Text("Device ID placeholder").padding()
            }
            CollapsibleCard("Hardware Fingerprint") {
                Text("Hardware details placeholder").padding()
            }
            CollapsibleCard("OS Fingerprint") {
                Text("OS details placeholder").padding()
            }
            Spacer()
        }
    }
}

//
//  CollapsibleCard.swift
//  DemoApp
//
//  Created by Petr Palata on 11.03.2022.
//

import SwiftUI

struct CollapsibleCard<CollapsibleContent: View>: View {
    let title: String
    let content: CollapsibleContent
    
    @State private var collapsed: Bool = true
    
    init(_ title: String, @ViewBuilder collapsibleContent: () -> CollapsibleContent) {
        // self.title = title
        self.title = title
        self.content = collapsibleContent()
    }
    
    var body: some View {
        VStack {
            Button(action: {
                collapsed = !collapsed
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(title)
                        Spacer()
                        Image(systemName: collapsed ? "chevron.down" : "chevron.up")
                    }
                }
                .contentShape(Rectangle())
                .padding()
            }
            .buttonStyle(.plain)
            if !collapsed {
                content
            }
        }
        .background()
        .cornerRadius(5)
        .shadow(radius: 2, y: 2)
    }
}

struct CollapsibleCard_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleCard("Test") {
            Text("TEST")
        }
    }
}

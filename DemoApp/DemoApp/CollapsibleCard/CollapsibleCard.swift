//
//  CollapsibleCard.swift
//  DemoApp
//
//  Created by Petr Palata on 11.03.2022.
//

import SwiftUI

struct CollapsibleCard<CollapsibleContent: View>: View {
    let title: String
    let subtitle: String?
    let content: CollapsibleContent
    
    @State private var collapsed: Bool = true
    
    init(_ title: String, subtitle: String? = nil, @ViewBuilder collapsibleContent: () -> CollapsibleContent) {
        self.title = title
        self.subtitle = subtitle
        self.content = collapsibleContent()
    }
    
    var body: some View {
        VStack {
            Button(action: {
                collapsed = !collapsed
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(title)
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .foregroundColor(.gray)
                                .fontWeight(.medium)
                        }
                    }
                    Spacer()
                    Image(systemName: collapsed ? "chevron.down" : "chevron.up")
                }
                .contentShape(Rectangle())
                .padding()
            }
            .buttonStyle(.plain)
            if !collapsed {
                content
            }
        }
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 2)
    }
}

struct CollapsibleCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CollapsibleCard("Title") {
                Text("Simple text subview")
            }
            CollapsibleCard("Title", subtitle: "Subtitle") {
                Image(systemName: "touchid")
                    .resizable(
                        capInsets: EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        ),
                        resizingMode: .tile
                    )
            }
        }
    }
}

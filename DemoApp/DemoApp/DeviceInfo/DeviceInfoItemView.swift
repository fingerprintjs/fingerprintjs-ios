//
//  DeviceInfoItemView.swift
//  DemoApp
//
//  Created by Petr Palata on 14.03.2022.
//

import SwiftUI

struct DeviceInfoItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        Divider()
        VStack(alignment: .leading) {
            Text(label).bold()
            Text(value).foregroundColor(.gray)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 8))
    }
}

struct DeviceInfoItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoItemView(label: "TestLabel", value: "Lorem ipsum")
    }
}

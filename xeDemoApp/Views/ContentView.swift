//
//  ContentView.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 15) {
            CustomSubView(title: "Title", placeholder: "Enter a title...")
            CustomSubView(title: "Location", placeholder: "Search a location...")
            CustomSubView(title: "Price", placeholder: "Enter a price...")
            CustomSubView(title: "Description", placeholder: "Add a description...")
            HStack(spacing: 30) {
                CustomButtonView(title: "Submit", action: {}, color: .green)
                CustomButtonView(title: "Clear", action: {}, color: .red)
            }
        }
        .padding()
        Spacer()
    }
}

//#Preview {
//    ContentView()
//}

//
//  CustomButtonView.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import SwiftUI

struct CustomButtonView: View {
    var title: String
    var action: () -> Void
    var color: Color
    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
        }
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.white)
    }
}

#Preview {
    CustomButtonView(title: "Title", action: {}, color: .blue)
}

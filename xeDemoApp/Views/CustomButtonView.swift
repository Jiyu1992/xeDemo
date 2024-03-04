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
    var enabled: Bool = true
    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
        }
        .disabled(!enabled)
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.white)
        .opacity(!enabled ? 0.5 : 1)
    }
}

#Preview {
    CustomButtonView(title: "Title", action: {}, color: .blue)
}

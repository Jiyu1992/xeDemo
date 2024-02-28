//
//  CustomSubView.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import SwiftUI

struct CustomSubView: View {
    var title: String
    var placeholder: String
    @State var searchString: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
            TextField(placeholder, text: $searchString, axis: .vertical)
                .padding()
                .background(Color(uiColor: .lightGray))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
        }
    }
}

//#Preview {
//    CustomSubView()
//}

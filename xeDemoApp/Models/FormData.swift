//
//  FormData.swift
//  xeDemoApp
//
//  Created by user256596 on 3/4/24.
//

import Foundation

struct FormData: Encodable {
    var title: String
    var location: String
    var price: String
    var formDescription: String
    
    init(title: String = "", location: String = "", price: String = "", description: String = "") {
        self.title = title
        self.location = location
        self.price = price
        self.formDescription = description
    }
}

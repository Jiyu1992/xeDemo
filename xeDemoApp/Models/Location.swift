//
//  LocationModel.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

struct Location: Decodable, Identifiable {
    
    let placeID, mainText, secondaryText: String
//  Identifiable conformance
    var id: String { placeID }

    enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case mainText, secondaryText
    }
}

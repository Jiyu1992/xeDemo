//
//  APIError.swift
//  xeDemoApp
//
//  Created by user256596 on 3/5/24.
//

import Foundation

enum ApiError: Error {
    case invalidResponse
    case decodingError
    case invalidStatusCode(Int)
    case invalidURL
}

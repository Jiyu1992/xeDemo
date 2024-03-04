//
//  EndpointProvider.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

struct Constants{
    static let baseURL = "4ulq3vb3dogn4fatjw3uq7kqby0dweob.lambda-url.eu-central-1.on.aws"
}

protocol EndpointProvider {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndpointProvider {
    var scheme: String {
        return "https"
    }

    var baseURL: String {
        return Constants.baseURL
    }


    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host =  baseURL
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw fatalError()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }
    
    func asURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host =  baseURL
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            return nil
        }
        return url
    }
}

enum Endpoints: EndpointProvider {
    case getLocations(query: String)
    var path: String {
        return ""
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getLocations(let query):
            return [URLQueryItem(name: "input", value: query)]
        }
    }
    
    
}

//
//  APIClient.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

protocol ApiProtocol {
    func makeRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T?
    func getLocations(for query: String) async throws -> [Location]?
}

final class ApiClient: ApiProtocol {
    private let locationCache: NSCache<NSString, CacheObject> = NSCache()
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
    
    func makeRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T? {
        let (data, response) = try await session.data(for: endpoint.asURLRequest())
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw ApiError.decodingError
            }
        default:
            throw ApiError.invalidStatusCode(response.statusCode)
        }
    }
    
    func getLocations(for query: String) async throws -> [Location]? {
        let endpoint = Endpoints.getLocations(query: query)
        guard let url = endpoint.asURL() else {
            throw ApiError.invalidURL
        }
        if let cached = locationCache[url] {
            switch cached {
            case .ready(let locations):
                return locations
            case .inProgress(let task):
                return try await task.value
            }
        }
        let task = Task<[Location], Error> {
            let locations = try await makeRequest(endpoint: endpoint, responseModel: [Location].self)
            return locations ?? []
        }
        locationCache[url] = .inProgress(task)
        do {
            let locations = try await task.value
            locationCache[url] = .ready(locations)
            return locations
        } catch {
            locationCache[url] = nil
            throw error
        }
    }
}

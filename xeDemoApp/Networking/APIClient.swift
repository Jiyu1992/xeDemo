//
//  APIClient.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

protocol ApiProtocol {
    func makeRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T?
}

final class ApiClient: ApiProtocol {
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
    
    func makeRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T? {
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            return try self.manageResponse(data: data, response: response)
        } catch let error {
            throw error
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T? {
        guard let response = response as? HTTPURLResponse else {
            return nil
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw error
            }
        default:
            return nil
        }
    }
}

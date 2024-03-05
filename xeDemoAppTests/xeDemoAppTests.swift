//
//  xeDemoAppTests.swift
//  xeDemoAppTests
//
//  Created by user256596 on 2/28/24.
//

import XCTest
import SwiftUI
@testable import xeDemoApp

final class xeDemoAppTests: XCTestCase {
    func testClientDoesFetchAndDecodeData() async throws {
        let apiClient = mockAPIClient()
        let locations = try await apiClient.makeRequest(endpoint: Endpoints.getLocations(query: ""), responseModel: [Location].self)
        XCTAssertEqual(locations?.count, 2)
        XCTAssertEqual(locations?[0].mainText, "Nafplio")
    }
    
    @MainActor 
    func testSubmitButtonIsDeactivatedInInitialState() {
        let apiClient = mockAPIClient()
        let provider = LocationsProvider(apiClient: apiClient)
        XCTAssertFalse(provider.determineSubmitReady(locationSelected: false, title: ""))
    }
    
    @MainActor
    func testSubmitButtonIsDeactivatedWithEmptyTitle() {
        let apiClient = mockAPIClient()
        let provider = LocationsProvider(apiClient: apiClient)
        XCTAssertFalse(provider.determineSubmitReady(locationSelected: true, title: ""))
    }
    
    @MainActor
    func testSubmitButtonIsDeactivatedWithNoLocationSelected() {
        let apiClient = mockAPIClient()
        let provider = LocationsProvider(apiClient: apiClient)
        XCTAssertFalse(provider.determineSubmitReady(locationSelected: false, title: "Patra"))
    }
    
    @MainActor
    func testSubmitButtonIsActivatedWithProperParameters() {
        let apiClient = mockAPIClient()
        let provider = LocationsProvider(apiClient: apiClient)
        XCTAssert(provider.determineSubmitReady(locationSelected: true, title: "Patra"))
    }

}

class mockAPIClient: ApiProtocol {
    func getLocations(for query: String) async throws -> [Location]? {
        try? await Task.sleep(nanoseconds: 3000)
        return try JSONDecoder().decode([Location].self, from: stubData)
    }
    
    func makeRequest<T>(endpoint: xeDemoApp.EndpointProvider, responseModel: T.Type) async throws -> T? where T : Decodable {
        try? await Task.sleep(nanoseconds: 3000)
        return try JSONDecoder().decode(T.self, from: stubData)
    }
}

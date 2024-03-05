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
        let locations = try await apiClient.makeRequest(endpoint: Endpoints.getLocations(query: ""), responseModel: [LocationModel].self)
        XCTAssertEqual(locations?.count, 2)
    }
    
//  Here we can observe the drawbacks of foregoing MVVM. Testing the logic is kind of tricky because we moved it to the View layer.
//  Considering the size and scope of this app this is completely fine but in a larger scale app we either follow the MVVM pattern
//  and test the ViewModel OR we use a more SwiftUI-friendly architecture like TCA
    @MainActor
    func testSubmitButtonIsDeactivatedInInitialState() {
//      As we manipulate the state variables INSIDE our View (instead of observing a VM or executing Actions of a Reducer in the TCA architecture)
//      the code below represents the initial state of our App and we can NOT influence it directly
        let view =  ContentView(locationProvider: LocationsProvider(apiClient: ApiClient()))
        XCTAssertFalse(view.isLocationSelected && !view.formData.title.isEmpty)
    }

}

class mockAPIClient: ApiProtocol {
    func makeRequest<T>(endpoint: xeDemoApp.EndpointProvider, responseModel: T.Type) async throws -> T? where T : Decodable {
        try? await Task.sleep(nanoseconds: 3000)
        return try JSONDecoder().decode(T.self, from: stubData)
    }
}

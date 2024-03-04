//
//  LocationsProvider.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//
// This is a very minimal ViewModel. In practice Apple and the communitty in general seems to steer away from the MVVM pattern.
// In my personal experience trying to "shoehorn" MVVM in SwiftUI when the framework itself provides almost everything (with property wrappers, binding etc) is a bit counter-intuitive.
// For example the code below could be ommited as a whole and we could implement an async getter for the LocationModel.
// Then we could simply ask for all elements of the struct in the View layer with something like this:
/*
 struct ContentView: View {
    @state var locations: [LocationModel]
    var body: some View {
        Vstack{
            blablabla
        }.task{
            locations = await locationModel.all
        }
    }
 }
 
 */

// If time allows I'll try to provide the approach discussed above (maybe commented out) and it could be a talking point in the code review


import Foundation

@MainActor
class LocationsProvider: ObservableObject {
    
    @Published var locations: [LocationModel] = []
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func getLocations(for query: String) async throws -> [LocationModel]? {
        return try await apiClient.getLocations(for: query)
    }
}

//
//  xeDemoAppApp.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import SwiftUI

@main
struct xeDemoAppApp: App {
    private let apiClient: ApiClient
    private let locationProvider: LocationsProvider
    
    init() {
        self.apiClient = ApiClient()
        self.locationProvider = LocationsProvider(apiClient: apiClient)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(locationProvider: locationProvider)
                .environmentObject(locationProvider)
        }
    }
}

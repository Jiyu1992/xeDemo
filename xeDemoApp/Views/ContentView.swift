//
//  ContentView.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    @State var formData: FormData = FormData()
    @StateObject var locationProvider: LocationsProvider
    @State var locations: [Location] = []
    @State var isLocationSelected: Bool = false
    @State var presentJSON: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                CustomSubView(title: "Title", placeholder: "Enter a title...", textFieldString: $formData.title)
                VStack(spacing: 0) {
                    CustomSubView(title: "Location", placeholder: "Search a location...", textFieldString: $formData.location)
                        .onChange(of: formData.location){
                            if formData.location.count > 3 && !isLocationSelected {
                                isLocationSelected = false
                                Task {
                                    locations =  await locationProvider.getLocations(for: formData.location) ?? []
                                }
                            }
                            if formData.location.count < 3 {
                                locations = []
                            }
                        }
                    if !locations.isEmpty && !isLocationSelected {
                        List {
                            ForEach(locations, id: \.id) { location in
                                Text(location.mainText + "," + location.secondaryText)
                                    .onTapGesture {
                                        isLocationSelected = true
                                        formData.location = location.mainText + "," + location.secondaryText
                                    }
                            }
                        }
                        .listStyle(.inset)
                        .frame(minHeight: 150)
                    }
                }
                CustomSubView(title: "Price", placeholder: "Enter a price...", textFieldString: $formData.price)
                CustomSubView(title: "Description", placeholder: "Add a description...", textFieldString: $formData.formDescription)
                Spacer()
                HStack(spacing: 30) {
                    CustomButtonView(
                        title: "Submit",
                        action: {
                            presentJSON = true
                        },
                         color: .green,
                        enabled: locationProvider.determineSubmitReady(locationSelected: isLocationSelected, title: formData.title)
                    )
                    .alert("\(formatJson())", isPresented: $presentJSON) {
                        Button("Done", role: .cancel) {
                            formData = FormData()
                        }
                    }
                    CustomButtonView(title: "Clear", action: { formData = FormData() }, color: .red, enabled: true)
                }
            }
            .padding()
        }
        
    }
    
    func formatJson() -> String {
        let data = try! JSONEncoder().encode(formData)
        let formated = try? JSONSerialization.jsonObject(with: data)
        return "\(formated ?? "")"
    }
}

//#Preview {
//    ContentView()
//}

//
//  PersonDetailView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

struct PersonDetailView: View {
    var person: Person
    
    @State private var selectedSubView = "Image"
    private let subViews = ["Image", "Location"]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedSubView, label: Text("Select")) {
                ForEach(subViews, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSubView == "Image" {
                Image(uiImage: person.image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .animation(.linear)
                    .transition(.asymmetric(insertion: .slide, removal: .move(edge: .leading)))
            } else {
                VStack {
                    Text("Longitude: \(person.location.longitude)")
                    Text("Latitude: \(person.location.latitude)")
                }
                .padding()
                .animation(.linear)
                .transition(.move(edge: .trailing))
            }
            Spacer()
        }
        .navigationBarTitle("\(person.firstName) \(person.lastName)")
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonDetailView(person: Person(firstName: "Test", lastName: "Person", image: UIImage(systemName: "camera")!, location: Coordinate(latitude: 0.0, longitude: 0.0)))
        }
    }
}

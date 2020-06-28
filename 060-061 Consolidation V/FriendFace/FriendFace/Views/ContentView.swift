//
//  ContentView.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                Text("\(user.name) (\(user.age))")
                    .foregroundColor(user.isActive ? .green : .black)
            }
            .navigationBarTitle("FriendFace")
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        // prepare the request for data
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Failed to create data url")
        }
        let request = URLRequest(url: url)
        
        // request the data
        URLSession.shared.dataTask(with: request) { data, response, error in
            // check if data is present
            if let data = data {
                // if so, handle it
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedResponse = try? decoder.decode([User].self, from: data) {
                    // on success, update the main queue with new data
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    // everything done
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

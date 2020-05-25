//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Brünen on 24.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // State properties
    @State private var checkAmount = ""         // cost of the check
    // Double would be better for numbers, but SwiftUI only allows strings in text views
    @State private var numberOfPeople = 2       // how many are sharing the cost
    @State private var tipPercentage = 2            // how much of a tip will be left
    
    // Constants
    let tipPercentages = [10, 15, 20, 25, 0]    // holds values for the tip picker
    
    // Computed properties
    // calculates the amount each person has to pay, tip included
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)  // get correct people count, convert to double
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0  // using nil coalescing to ensure a safe value
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // TextField view with a placeholder text and two-way binding to the state property
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)  // only show a decimal keypad to avoid non-digits
                    
                    // Picker view for the number of people splitting the check
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 21) {
                            // create a row up to 20 people
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    // Picker view for the tip percentage selection
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            // create a 'row' for every tip percentage option
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())    // best suited for fewer items
                }
                
                Section {
                    // display the total amount per person, specifier reduces digits after comma to 2
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

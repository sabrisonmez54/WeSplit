//
//  ContentView.swift
//  WeSplit
//
//  Created by Sabri Sönmez on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection

        return checkAmount + tipValue
    }
    var totalPerPerson: Double {
        let amountPerPerson = grandTotal / Double(numberOfPeople + 2)

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount per person") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total Amount of Check") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))

                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

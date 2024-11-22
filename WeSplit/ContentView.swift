//
//  ContentView.swift
//  WeSplit
//
//  Created by Adrian Mowat on 22/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocussed: Bool
    
    let tipPercentages = [10, 15,20, 25, 0]
    let localCurrecyCode = Locale.current.currency?.identifier ?? "USD"
    
    var tipAmount: Double {
        let tipSelection = Double(tipPercentage)
        return checkAmount/100 * tipSelection
    }
    
    var totalAmount: Double { checkAmount + tipAmount }
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return checkAmount + tipAmount / peopleCount
    }
    
    
    var body: some View {
        NavigationStack {
            Form{
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: localCurrecyCode))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocussed)
                }
                
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much of a tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Tip") {
                    Text(tipAmount, format: .currency(code: localCurrecyCode))
                }
                
                Section("Grand Total") {
                    Text(totalAmount, format: .currency(code: localCurrecyCode))
                    
                }
                
                
                Section("Each person pays") {
                    Text(totalPerPerson, format: .currency(code: localCurrecyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocussed {
                    Button("Done") {
                        amountIsFocussed = false
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

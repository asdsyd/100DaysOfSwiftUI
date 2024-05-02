//
//  ContentView.swift
//  WeSplit
//
//  Created by Asad Sayeed on 08/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberofPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calc per person total
        let peopleCount = Double(numberofPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100*tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100*tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberofPeople) {
                        ForEach(2..<11) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip? ") {
                    //Project-1 Challenge-3: Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options - everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
                    Picker("Tip percentage", selection:  $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Text("Tip selected: \(tipPercentage) %")
                    
                    
                }
                
                //Project-1 Challenge-1: Add a header to the third section, saying "Amount per person"
                Section ("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
                //Project-1 Challenge-2: Add another section showing the total amount for the check - i,e the original amount plus tip value, without dividing by the number of people.
                Section ("Total amount: ") {
                    Text(grandTotal,
                         format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    //P3-C1: Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.
                    .foregroundStyle(tipPercentage == 0 ? .red : .blue)
                }
                
            }
            .navigationTitle("WeSplit")
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

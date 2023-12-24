//
//  ContentView.swift
//  Convertase
//
//  Created by Asad Sayeed on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.yards
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Temperature", "Length", "Time", "Volume"]
    let unitTypes = [
        [UnitTemperature.celsius, UnitTemperature.kelvin, UnitTemperature.fahrenheit],
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours],
        [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    ]
    
    @State var selectedUnits = 0
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var result: String {
        let inputLength = Measurement(value: input, unit: inputUnit)
        let outputLength = inputLength.converted(to: outputUnit)
        return formatter.string(from: outputLength)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter a value", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("value to convert")
                }
                
                
                Section ("Conversion type") {
                    Text("Result will be in standard units")
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count) {
                            Text(conversions[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                    
                    
                Section ("Convert from") {
                    Picker("Convet from", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result converted to: ")
                }
                
            }
            .navigationTitle("Convertase")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { newSelection in
                let units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
}
    
    

#Preview {
    ContentView()
}

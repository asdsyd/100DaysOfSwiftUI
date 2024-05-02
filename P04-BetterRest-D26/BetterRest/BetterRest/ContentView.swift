//
//  ContentView.swift
//  BetterRest
//
//  Created by Asad Sayeed on 24/11/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTiem
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTiem: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // P4-C1: Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing:0 ) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
//                VStack(alignment: .leading, spacing:0 ) {
//                    Text("Daily coffee intake")
//                        .font(.headline)
//                    
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    
                    // P4-C2: Replace the “Number of cups” stepper with a Picker showing the same range of values.
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                
                // P4-C3: Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
                Section {
                    HStack {
                        Text("Calculated bedtime: ")
                        Spacer()
                        Text("\(calculateBedtime())")
                    }
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
    
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            let calculatedBedTime = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
            
            return calculatedBedTime
        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime!"
            let calculatedBedTime = "Error"
            return calculatedBedTime
        }
        
//        showingAlert = true
    }
    
}

#Preview {

    ContentView()
}

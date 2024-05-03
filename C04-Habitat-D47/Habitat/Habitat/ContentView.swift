//
//  ContentView.swift
//  Habitat
//
//  Created by Asad Sayeed on 02/05/24.
//

import SwiftUI

// Day-47 | Milestone: Projects 7-9
// Challenge Project - 4: Habitat
// Problem statement: https://www.hackingwithswift.com/guide/ios-swiftui/4/3/challenge
struct Activity: Identifiable, Codable {
    let id: UUID()
    let name: String
    let description: String
}

@Observable
class Activities {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(items: <#type#> = [Activity]()) {
        self.items = items
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

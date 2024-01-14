//
//  ContentView.swift
//  Navigation
//
//  Created by Asad Sayeed on 09/01/24.
//

import SwiftUI


struct DetailView: View
{
    var number: Int
    
    var body: some View 
    {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View 
{
    @State private var path = NavigationPath()
    
    var body: some View
    {
        NavigationStack(path: $path)
        {
            List
            {
                ForEach(0..<5)
                { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }
                
                ForEach(0..<5)
                { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .toolbar
            {
                Button("Push 556")
                {
                    path.append(556)
                }
                
                Button("Push hello")
                {
                    path.append("hello")
                }
            }
            .navigationDestination(for: Int.self)
            { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self)
            { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  MoonShot
//
//  Created by Asad Sayeed on 02/01/24.
//

import SwiftUI

// P15-C3: Do a full accessibility review of Moonshot – what changes do you need to make so that it’s fully accessible?
struct ContentView: View
{
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @AppStorage("showingGrid") private var showingGrid = true
    
    var body: some View
    {
        // P9-C3: Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().
        //challenge code is in GridLayout
        NavigationStack
        {
                // P8-C3: For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
                Group
                {
                        if showingGrid {
                            GridLayout(missions: missions, astronauts: astronauts)
                        } else {
                            ListLayoutView(missions: missions, astronauts: astronauts)
                        }
                }
                .toolbar {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        if showingGrid {
                            Label("Show as List", systemImage: "list.dash")
                        } else {
                            Label("Show as Grid", systemImage: "square.grid.2x2")
                        }
                    }
                }
                .navigationTitle("MoonShot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }

#Preview {
    ContentView()
}

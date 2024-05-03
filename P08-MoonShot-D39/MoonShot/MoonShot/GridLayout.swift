//
//  GridLayout.swift
//  MoonShot
//
//  Created by Asad Sayeed on 02/05/24.
//

import SwiftUI

struct GridLayout: View {
    let  missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView
        {
            LazyVGrid(columns: columns)
            {
                ForEach(missions)
                { mission in
                    // P9-C3: Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().
                    NavigationLink(value: mission)
                    {
//                    {
//                        MissionView(mission: mission, astronauts: astronauts)
//                    } label:
//                    {
                        VStack
                        {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        
                            VStack
                            {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground))
                    }
                    .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}



#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    
    return GridLayout(missions: missions, astronauts: astronauts)
}

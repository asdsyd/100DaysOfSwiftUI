//
//  ListLayoutView.swift
//  MoonShot
//
//  Created by Asad Sayeed on 02/05/24.
//

import SwiftUI

struct ListLayoutView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    let missions : [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    
    return ListLayoutView(missions: missions, astronauts: astronauts)
}

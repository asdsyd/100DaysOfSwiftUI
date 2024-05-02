//
//  MissionView.swift
//  MoonShot
//
//  Created by Asad Sayeed on 06/01/24.
//

import SwiftUI



struct MissionView: View
{
    struct CrewMember
    {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View 
    {
        ScrollView
        {
            VStack
            {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                    width * 0.6
                }
                
                // P8-C1: Add the launch date to MissionView, below the mission badge. You might choose to format this differently given that more space is available, but it’s down to you.
                Text("Launch Date: \(mission.formattedLaunchDate)")
                                
                VStack(alignment: .leading)
                {
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundStyle(.lightBackground)
//                        .padding(.vertical)
                    DividerView()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    // P8-C2: Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
                    DividerView()
                    
//                    NavigationStack {
//                        NavigationLink("Tap me here") {
//                            Text("Detailed view of crew")
//                        }
//                        .foregroundColor(.white)
//                    }
//                    .foregroundColor(.lightBackground)
                    
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundStyle(.lightBackground)
//                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false)
                {
                    HStack
                    {
                        ForEach(crew, id: \.role)
                        {
                            crewMember in
                            NavigationLink
                            {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack
                                {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.secondary)
                                            )
                                    
                                    VStack(alignment: .leading)
                                    {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        
        
    }
    
    init(mission: Mission, astronauts: [String: Astronaut])
    {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    
    
    
    
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

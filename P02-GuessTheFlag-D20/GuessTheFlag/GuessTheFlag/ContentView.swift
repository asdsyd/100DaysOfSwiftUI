//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Asad Sayeed on 11/11/23.
//

import SwiftUI

// P3-C2: Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.
struct FlagImage: View {

    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
//        Testing if this also works with git versioning
            
        
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // P2-C1: Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
    @State private var userScore = 0
    @State private var questionsDisplayed = 0
    
    @State private var animationAmount = 360.0
    @State private var selectedFlag = -1
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe is gold with crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Tope stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
            
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                                                        
                        } label: {
                            FlagImage(name: countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .padding(10)
                            // P6-C2: Make the other two buttons fade out to 25% opacity.
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25 )
                            // P6-C3: Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? Or flip in a different direction? Experiment!
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.5)
                            // P6-C1: When you tap a flag, make it spin around 360 degrees on the Y axis.
                                .rotation3DEffect(
                                    .degrees(selectedFlag == correctAnswer ? animationAmount : 0.0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .animation(.default , value: animationAmount )

                                
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionsDisplayed == 8 {
                Button("Restart", action: resetGame)
            } else {
                Button("Continue", action: askQuestion)
            }
            
        } message: {
            if questionsDisplayed == 8 {
                Text("The End! Your score is: \(userScore)/800")
            }
        }
    }
            
            
            func flagTapped(_ number: Int) {
                selectedFlag = number
                
                if number == correctAnswer {
                    scoreTitle = "Correct! That's the flag of \(countries[number])!"
                    userScore += 100
                    
                } else {
                    // P2-C2: When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
                    scoreTitle = "Wrong! That's the flag of \(countries[number])"
                    userScore -= 20
                    
                }
                showingScore = true
                
                // P2-C3: Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
                if questionsDisplayed == 8 {
                    showingScore = true
                }
            }
            
            func askQuestion() {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
                questionsDisplayed += 1
                selectedFlag = -1

                
            }
    
            func resetGame() {
                userScore = 0
                questionsDisplayed = 1
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
            }
        }


#Preview {
    ContentView()
}

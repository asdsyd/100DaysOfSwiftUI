//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Asad Sayeed on 11/11/23.
//

import SwiftUI

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
    
    @State private var userScore = 0
    @State private var questionsDisplayed = 0
//    @State private var restartTitle = ""
    
    @State private var animationAmount = 360.0
    @State private var selectedFlag = -1

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
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25 )
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.5)
                                .rotation3DEffect(
                                    .degrees(selectedFlag == correctAnswer ? animationAmount : 0.0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .animation(.default , value: animationAmount )

                                
                        }
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
                    scoreTitle = "Wrong! That's the flag of \(countries[number])"
                    userScore -= 20
                    
                }
                showingScore = true
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

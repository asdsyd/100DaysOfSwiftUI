//
//  ContentView.swift
//  ScissorYourBrain
//
//  Created by Asad Sayeed on 28/11/23.
//

import SwiftUI

struct ContentView: View {
    let options = ["👊", "🤚", "✌️"]
    
    @State private var choice = Int.random(in: 0..<3)
    @State private var shouldWin = false
    @State private var score = 0
    @State private var round = 0
    @State private var scoreAlert = false
    
    var body: some View {
        VStack {
            Text("The AI has played")
                .font(.title)
            
            Text(options[choice])
                .font(.system(size: 250))
            
            if shouldWin {
                Text("You need to Win")
                    .font(.title)
                    .foregroundStyle(.green)
            } else {
                Text("You need to Lose")
                    .font(.title)
                    .foregroundStyle(.red)
            }
            
            
            
            Spacer()
            Text("⬇️🔻⬇️🔻⬇️🔻⬇️🔻⬇️🔻⬇️🔻⬇️")
                .font(.title2)
            HStack {
                ForEach(0..<3) { number in
                    Button(options[number]){
                        game(number)
                    }
                    .font(.system(size: 100))
                    
                }
            }
            Text("⬆️🔺⬆️🔺⬆️🔺⬆️🔺⬆️🔺⬆️🔺⬆️")
                .font(.title2)
            Spacer()
            
            Text("Score: \(score)")
                .font(.title)
            
            
        }
        .padding()
        .alert("Game Over!", isPresented: $scoreAlert){
            Button("Play Again!", action: resetGame)
        } message: {
            Text("Final Score: \(score)")
        }
    }
    
    func game(_ number: Int) {
        let winningMoves = [1, 2, 0]
        var didWin: Bool
        
        if shouldWin {
            didWin = number == winningMoves[choice]
        } else {
            didWin = winningMoves[number] == choice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if round == 10 {
            scoreAlert = true
        } else {
            round += 1
            choice = Int.random(in: 0..<3)
            shouldWin.toggle()
        }
    }
    
    func resetGame() {
        score = 0
        round = 0
        choice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
}




#Preview {
    ContentView()
}

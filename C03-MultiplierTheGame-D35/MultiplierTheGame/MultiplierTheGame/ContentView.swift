//
//  ContentView.swift
//  MultiplierTheGame
//
//  Created by Asad Sayeed on 14/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var num1 = Int()
    @State private var num2 = Int()
    @State private var correctAnswer = Int()
    @State private var numberOfQuestions = [5, 10, 20]
    @State private var selectedDifficultyIndex = 0
    @State private var questionNumber = Int()
    @State private var score = 0
    @State private var randomAnswers = [Int]()
    @State private var selectedNumberOfQuestions = 5
    @State private var difficulty = ["Easy", "Medium", "Hard"]
    @State private var tables = 1
    
    @State private var isVisible = false
    @State private var endGame = false
        
    var body: some View 
    {
        VStack
        {
            VStack
            {
                Text("Multiplier The Game")
                    .font(.largeTitle)
                
            HStack
                {
                Section(header: Text("Up to which table?")) 
                    {
                    Stepper(value: $tables, in: 2...12)
                        {
                        Text("\(tables)")
                        }
                        .padding()
                    }
                }
                .padding()
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
                VStack 
                {
                    Section(header: Text("Select the question pack!"))
                    {
                        Picker("Number of Questions", selection: $selectedNumberOfQuestions) 
                        {
                            ForEach(numberOfQuestions, id: \.self)
                            { questionCount in
                                
                                Text("\(questionCount)")
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Select Difficulty")) 
                    {
                        Picker("Difficulty", selection: $selectedDifficultyIndex) 
                        {
                            ForEach(0..<difficulty.count, id: \.self) 
                            { index in
                                
                                Text("\(difficulty[index])")
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .padding()
            
            Divider()
            
            Text("Question: \(questionNumber)")
                .padding(5)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            HStack
            {
                Text("What is \(num1) x \(num2) = ? ")
                    .font(.title)
                    .padding()
                Text("🤔💬")
                    .font(.title)
            }
                
            HStack
            {
                ForEach(randomAnswers, id: \.self)
                { num in
                    Button
                    {
                        withAnimation
                        {
                            numberTapped(num)
                        }
                    } label: 
                    {
                        Text("\(num)")
                            .frame(width:100, height: 100)
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .background(.blue)
                            .clipShape(Circle())
                    }
                    .padding(.vertical, 8.0)
                    .alert("Well done, Game Over !", isPresented: $endGame)
                    {
                        Button("New Game", action: resetGame)
                    } message: {
                        Text("Your score is \(score)")
                    }
                    
                }
            }
            Spacer()
            
            if !isVisible
            {
                Button
                {
                    answer()
                    isVisible.toggle()
                } label: {
                    Text("Play")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                .padding()
            }
            
            Text("Your score is \(score)")
                .font(.headline)
            
                
            }
        } //var body
    
    func answer()
    {
        for _ in 1...3
        {
            num1 = Int.random(in: 1...tables)
            num2 = Int.random(in: 1...tables)
            
            correctAnswer = num1 * num2
            randomAnswers.append(correctAnswer)
            
        }
        createRandomAnswers()
    }
    
    func createRandomAnswers()
    {
        randomAnswers.shuffle()
    }
    
    func numberTapped(_ num: Int)
    {
        if num == correctAnswer
        {
            score += 30
            questionNumber += 1
            randomAnswers.removeAll()
            answer()
        } else
        {
            randomAnswers.removeAll()
            questionNumber += 1
            score -= 10
            answer()
        }
        
        if selectedNumberOfQuestions == questionNumber
        {
            endGame = true
        }
    }
    
    func resetGame() 
    {
        questionNumber = 0
        score = 0
        randomAnswers.removeAll()
        isVisible.toggle()
    }
    
}

#Preview {
    ContentView()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

//
//  ContentView.swift
//  WordScramble
//
//  Created by Asad Sayeed on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    @State private var nLetters = 0
    @State private var nWords = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Text(word)
                            Image(systemName: "\(word.count).circle")
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit() {
                addNewWord()
            }
            .onAppear(perform:startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: { Text(errorMessage) }
            
            Section {
                Text("Current Score: \(score)")
                    .foregroundStyle(.green)
                    .font(.title)
            }
        
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Start a new Game") {
                    startGame()
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isNotShort(word: answer) else {
            wordError(title: "word too short", message: "You should form a word with atleast 3 letters")
            return
        }
        
        guard isNotWordItself(word: answer) else {
            wordError(title: "Word not possible", message: "Root word is not counted! Try again!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "You cannot spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "word not recognised", message: "You can't just make them up!")
            return
        }
        
        withAnimation{usedWords.insert(answer, at: 0)
        }
        newWord = ""
        
        nLetters += answer.count
        nWords += 1
        score = nWords * nLetters
        
    }
    
    func startGame () {
        score = 0
        nLetters = 0
        nWords = 0
//        usedWords.removeAll()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isNotWordItself(word: String) -> Bool {
        !word.contains(rootWord)
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isNotShort(word: String) -> Bool {
        if word.count <= 2 {
            return false
        }
        return true
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

#Preview {
    ContentView()
}

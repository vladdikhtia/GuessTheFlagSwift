//
//  ContentView.swift
//  DAY21_GuessTheFlag
//
//  Created by Vladyslav Dikhtiaruk on 01/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var stopGame = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var amountOfQuestions = 0
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .green, location: 0.3),
                .init(color: .white, location: 0.45),
                .init(color: .red, location: 0.65)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
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
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 80)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 30))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score) / \(amountOfQuestions)")
                    .foregroundStyle(.secondary)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("OK", role: .cancel, action: {
                askQuestion()
            })
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game is finished", isPresented: $stopGame) {
            Button("Game is finished OK", role: .cancel) {
                resetGame()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle =  "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        amountOfQuestions += 1
        showingScore = true
        if(amountOfQuestions >= 8){
            stopGame = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        score = 0
        amountOfQuestions = 0
        print("Game resetting...")
        askQuestion()
    }
}

#Preview {
    ContentView()
}

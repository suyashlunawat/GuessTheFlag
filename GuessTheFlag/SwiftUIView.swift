//
//  SwiftUIView.swift
//  GuessTheFlag
//
//  Created by Suyash Lunawat on 04/12/21.
//

import SwiftUI

struct FlagImage: View {
var image: String
var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 50)
        
        }
    }


struct SwiftUIView: View {
    @State private var scaleTracker = 1.0
    @State private var flagTapTracker = 0
    @State private var animationAmount = 0.0
    @State private var opacityTracker = 1.0
    @State private var showingScore = false
    @State private var alertTriggered = 0
    @State private var nthQuestion = 1
    @State private var alertChecker = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain", "UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
                        ZStack {
               
                                RadialGradient(stops: [
                                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3, opacity: 1), location: 0.20),
                                .init(color: Color(red: 0.2, green: 0.3, blue: 0.4, opacity: 0.5), location: 0.20)
                            ], center: .top, startRadius: 300, endRadius: 700)
                                .ignoresSafeArea()
                            
                                            VStack {
                                                Spacer()
                                                Text("Guess The Flag")
                                                    .font(.largeTitle.bold())
                                                    .foregroundColor(.white)
                                                Text("\(nthQuestion) out of 8")
                                                    .foregroundStyle(.white)
                                                            VStack(spacing: 10){
                                                                        VStack{
                                                                            Text("Tap The Flag of")
                                                                                .foregroundStyle(.secondary)
                                                                                .font(.subheadline.weight(.heavy))
                                                                            Text(countries[correctAnswer])
                                                                              
                                                                                .font(.largeTitle.weight(.semibold))
                                                                        }
                                                           
                                                ForEach(0..<3){ number in
                                                Button {
                                                flagTapped(number)
                                                
                                                    withAnimation {
                                                animationAmount += 360
                                                opacityTracker -= 0.75
                                                scaleTracker -= 0.50
                                                    }

                                                   
                                                    
// flag was tapped
                                                }
                                                label: {
                                                    FlagImage(image: countries[number])
                                                        .rotation3DEffect(.degrees(number == flagTapTracker ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                                                        .opacity(number != flagTapTracker ? opacityTracker : 1)
                                                        .scaleEffect(number != flagTapTracker ? scaleTracker : 1)
                                                        

                                                }

                                                                }

                                                                
                
                                                            } .frame(width: 300, height: 450)
                                                    .background(.ultraThinMaterial)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                                    
                                                    
                                                Spacer()
                                                Spacer()
                                                Text ("Your Score is \(score)")
                                                    .foregroundColor(.white)
                                                    .font(.title.bold())
                                                Spacer()
                                            }
                           
                          
                        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text("Your Score is \(score)")
        }
        .alert("You have reached the end of the game", isPresented: $alertChecker) {
            Button("Restart New Game") {
                reset()
            }
        } message: {
            Text ("Your got \(score) correct out of 8")
        }
       
}
func flagTapped(_ number : Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            showingScore = true
        }
        else {
            scoreTitle = "Wrong! This is \(countries[number])"
            showingScore = true
            
            
        }
        addQuestion()
        flagTapTracker = number
}
    
func askQuestion() {
        alertTriggered += 1
        if alertTriggered == 8 {
            alertChecker = true
        }
        countries.shuffle()
        flagTapTracker = 4
        opacityTracker = 1
        scaleTracker = 1
        correctAnswer = Int.random(in: 0...2)
    }
    
func addQuestion() {
        nthQuestion += 1
       if nthQuestion == 9 {
            nthQuestion = 8
             }
    }
func reset() {
    score = 0
    nthQuestion = 1
    alertTriggered = 0
    
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

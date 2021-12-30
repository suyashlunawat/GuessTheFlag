//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Suyash Lunawat on 03/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var alert = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
//       
                
                AngularGradient(gradient: Gradient(colors: [.red, .blue,.green,.yellow,.white, .red]), center: .center)
              
            
           
        }
            VStack{
            Button("Hello, World!",action: executeDelete)
            
//            .foregroundStyle(.secondary)
            
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                Button {
                    alert = true
                    print("Do Something")
                }
                
            label: {
                    Label("Edit", systemImage: "pencil")
                        .padding()
                        .foregroundColor(.white)
            
                }
            .alert("Hello World", isPresented: $alert) {
                Button("Oops Thats a wrong alert", role: .cancel) {}
                Button("Delete", role: .destructive){}
            } message: {
                Text("I just messed up the alerts! Click anyone and continue the app")
            }
                
            }
        }
        .ignoresSafeArea()
    }
    func executeDelete() {
 print ("deleted")
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

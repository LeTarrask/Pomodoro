//
//  ContentView.swift
//  Pomodoro
//
//  Created by Alex Luna on 23/03/2020.
//  Copyright © 2020 Garagem Infinita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pomoModel = PomoModel()
    
    var body: some View {
        ZStack {
            if pomoModel.isResting {
                Color.green
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.red
                    .edgesIgnoringSafeArea(.all)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Pomodoro tracker")
                    .font(.headline)
                Text("Pomodoros completed: \(pomoModel.pomosCompleted)")
                    .font(.subheadline)
                if pomoModel.seconds < 1 {
                    Button(action: { self.pomoModel.createTimer() },
                    label: { Text("Start Pomo")})
                } else {
                    Text(pomoModel.label)
                }
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

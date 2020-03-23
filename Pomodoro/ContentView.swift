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
            VStack {
                Text("Pomodoro tracker")
                Text("Pomodoros completed: \(pomoModel.pomosCompleted)")
                Button(action: { self.pomoModel.startPomo() },
                       label: { Text("Start Pomo")})
            }
            .padding(20)
            .background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

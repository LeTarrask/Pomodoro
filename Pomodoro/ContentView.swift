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
        VStack {
            Text("Pomodoro tracker")
            Text("Pomodoros completed: \(pomoModel.pomosCompleted)")
            Button(action: { self.pomoModel.startPomo() },
                   label: { Text("Start Pomo")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

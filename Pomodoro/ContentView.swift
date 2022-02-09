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
    
    @State var selectedTime = 1500.0
        
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
                    VStack {
                        Text("Next Pomodoro duration:")
                        Picker(selection: $selectedTime, label: Text("Pomodoro: "), content: {
                            Text("15").tag(900.0)
                            Text("20").tag(1200.0)
                            Text("25").tag(1500.0)
                            Text("30").tag(1800.0)
                            Text("35").tag(2100.0)
                            }).pickerStyle(SegmentedPickerStyle())
                        Button(action: {
                            self.pomoModel.counter = self.selectedTime
                            
                            self.pomoModel.createTimer()
                        },
                        label: { Text("Start Pomo")})
                    }
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(pomoModel.label)
                        if pomoModel.timerRunning {
                            Button(action: { self.pomoModel.stopTimer() },
                            label: { Text("Pause Timer")})
                        } else {
                            HStack {
                                Button(action: { self.pomoModel.startTimer() },
                                label: { Text("Restart Timer")})
                                Button(action: { self.pomoModel.resetTimer() },
                                label: { Text("Reset Timer")})
                            }
                        }
                    }
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

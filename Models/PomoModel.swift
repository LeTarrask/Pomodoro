//
//  Timer.swift
//  Pomodoro
//
//  Created by Alex Luna on 23/03/2020.
//  Copyright © 2020 Garagem Infinita. All rights reserved.
//

import Foundation
import AVFoundation

final class PomoModel: ObservableObject {
    @Published var pomosCompleted: Int = 0
    
    @Published var isResting = false
    
    var timer: Timer?
    
    @Published var timerRunning = false
    
    var counter = 0.0
        
    @Published var seconds = 0.0
    
    @Published var label = ""
    
    func createTimer() {
        seconds = counter
        startTimer()
    }
    
    func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0,
        target: self,
        selector: #selector(updateTime),
        userInfo: nil,
        repeats: true)
    }
    
    func stopTimer() {
        timerRunning = false
        timer?.invalidate()
    }
    
    @objc func updateTime() {
        label = timeString(time: seconds)
        
        seconds -= 1
        
        if seconds < 1 {
            stopTimer()
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // Makes the phone vibrate
            
            self.isResting.toggle()
            
            if isResting {
                pomosCompleted += 1
                if pomosCompleted % 4 == 0 {
                    counter = 1200.0
                } else if isResting {
                    counter = 300.0
                }
                createTimer()
            } else {
                counter = 1500.0
            }
        }
    }
    
    // MARK: String Formatter for Countdown Label
    func timeString(time: Double) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}


extension Double {// THIS CODE CAME FROM OTHER APP. DO WE NEED IT?
    var seconds: Double { return self }

    var minutes: Double { return self.seconds * 60 }

    var hours: Double { return self.minutes * 60 }

    var days: Double { return self.hours * 24 }

    var weeks: Double { return self.days * 7 }

    var months: Double { return self.weeks * 4 }

    var years: Double { return self.months * 12 }
}

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
    
    var counter = Counter.working
    
    @Published var seconds = 0.0
    
    @Published var label = ""
    
    func createTimer() {
        switch isResting {
        case false:
            counter = Counter.working
        case true:
            if pomosCompleted % 4 == 0 {
                counter = Counter.superRest
            } else {
                counter = Counter.resting
            }
        }
        
        print(counter)
        seconds = counter.rawValue
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
                createTimer()
            }
        }
    }
    
    // MARK: String Formatter for Countdown Label
    func timeString(time: Double) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

enum Counter: Double {
    case working = 15.0 // divided by 100 for testing purposes
    case resting = 3.0 // divided by 100 for testing purposes
    case superRest = 12.0 // divided by 100 for testint purposes
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

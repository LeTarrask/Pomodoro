//
//  Timer.swift
//  Pomodoro
//
//  Created by Alex Luna on 23/03/2020.
//  Copyright © 2020 Garagem Infinita. All rights reserved.
//

import Foundation

final class PomoModel: ObservableObject {
    @Published var pomosCompleted: Int = 0
    
    var isResting = false
    
    var timer: Timer?
    
    func startPomo() {
        var counter = Counter.working

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
        timer = Timer.scheduledTimer(timeInterval: counter.rawValue,
                                     target: self,
                                     selector: #selector(endPomo),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func endPomo() {
        self.isResting.toggle()
        
        if isResting {
            pomosCompleted += 1
            startPomo()
        }
        
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

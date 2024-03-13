//
//  SharedTimer.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 11/03/24.
//

import Foundation

class SharedTimer: ObservableObject {
    let userDefaults: UserDefaults
    
    @Published var startTime: Double {
        didSet {
            userDefaults.set(startTime, forKey: "startTime")
        }
    }
    @Published var curSesh: Int {
        didSet {
            userDefaults.set(curSesh, forKey: "sharedSesh")
        }
    }
    
    init() {
       
        // Cria uma instância do UserDefaults com o App Group especificado
        guard let userDefaults = UserDefaults(suiteName: appGroup) else {
            fatalError("Could not load UserDefaults for suite \(appGroup)")
        }
        
        self.userDefaults = userDefaults
        
        self.startTime = userDefaults.double(forKey: "startTime")
        self.curSesh = userDefaults.integer(forKey: "sharedSesh")
    }
    
    func updateTimer(newTimer: Double) {
        startTime = newTimer
    }

}

//
//  Cat.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 07/03/24.
//

import Foundation

class Cat {
    var name: String
    var pomodoros: Pomodoro
    
    init(name: String, pomodoros: Pomodoro) {
        self.name = name
        self.pomodoros = pomodoros
    }
}

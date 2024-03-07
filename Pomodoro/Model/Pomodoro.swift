//
//  Pomodoros.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 07/03/24.
//

import Foundation

class Pomodoro {
    var time: Double
    var tag: Tag
    
    init(time: Double, tag: Tag) {
        self.time = time
        self.tag = tag
    }
}

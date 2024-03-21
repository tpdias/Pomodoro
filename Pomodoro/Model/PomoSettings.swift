//
//  Settings.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import Foundation

enum PomoSettings: String, CaseIterable {
    case vibration
    case sound
    case notification
}

enum PomoSounds: String, CaseIterable {
    case none
    case white
    case brown
    case black
    case lofi
    case rain
    case forest
    case wind
}

enum PomoTimers: String, CaseIterable {
    case study
    case pomoBreak
}

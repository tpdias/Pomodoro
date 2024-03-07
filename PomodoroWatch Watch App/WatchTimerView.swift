//
//  WatchTimer.swift
//  PomodoroWatch Watch App
//
//  Created by Thiago Parisotto on 07/03/24.
//

import SwiftUI

struct WatchTimerView: View {
    var pomoTime: Double
    var pauseTime: Double
    @State var backColor: Color
    init(pomoTime: Double, pauseTime: Double, backColor: Color) {
        self.pomoTime = 25 * 60.0
        self.pauseTime = 5 * 60.0
        self.backColor = .green
    }
    var body: some View {
        ZStack {
            Color(backColor)
                .ignoresSafeArea()
            VStack {
                Text(String(format: "%02d:%02d", Int(pomoTime) / 60, Int(pomoTime) % 60))
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}


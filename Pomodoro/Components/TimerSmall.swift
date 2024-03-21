//
//  TimerSmall.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import SwiftUI

struct TimerSmall: View {
    @Binding var time: Double
    @Binding var color: Color
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60))
                .font(Font.smallTimer())
                .kerning(3.2)
                .multilineTextAlignment(.center)
                .foregroundColor(color)
                .contentTransition(.numericText(value: time))
                .animation(.snappy, value: time)
        }
        .padding(.leading, 0)
        .padding(.trailing, 1)
        .padding(.vertical, 0)
        .frame(alignment: .center)
    }
}

//
//  TimerView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import SwiftUI

struct TimerComponent: View {
    @State var time: Double
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack {
                Text(String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60))
                    .font(Font.timer())
                    .kerning(4.8)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.Black2)
                Text(String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60))
                .font(Font.timer())
                .kerning(4.8)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MainBG)
            }
        }
            .padding(.horizontal, 1)
            .padding(.vertical, 0)
            .frame(height: 108, alignment: .center)

    }
}

#Preview {
    TimerComponent(time: 25.0 * 60)
}

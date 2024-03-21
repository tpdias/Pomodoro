//
//  TimerProperty.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 13/03/24.
//

import SwiftUI

struct TimerProperty: View {
    var optionName: String
    @Binding var isOn: Bool
    var time: Double
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 100)
                .background(isOn ? Color.Secondary : Color.Gray5)
                .cornerRadius(30)
            ZStack {
                VStack {
                    Spacer()
                    Text(String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60))
                        .font(
                        Font.timerButton()
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.Black3)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text(optionName)
                        .font(Font.custom("Noto Sans", size: 13))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.Black1)
                        .frame(width: 100, alignment: .top)
                }
                .padding(.vertical, 4)
            }
            
        }
        .frame(width: 100, height: 100)
        
    }
}

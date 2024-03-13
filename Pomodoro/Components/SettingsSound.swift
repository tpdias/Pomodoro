//
//  SettingsSound.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 13/03/24.
//

import SwiftUI

struct SettingsSound: View {
    var optionName: String
    @Binding var isOn: Bool
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 75, height: 75)
                .background(isOn ? Color.Gray2 : Color.Gray5)
                .cornerRadius(25)
            VStack {
                Spacer()
                Text(optionName)
                    .font(Font.custom("Noto Sans", size: 13))
                    .multilineTextAlignment(.center)
                    .foregroundColor(isOn ? Color.SecondBG : Color.Black2)
            }
            .padding(.vertical, 2)
        }
        .frame(width: 75, height: 75)
        .padding(0)
        
        
    }
}


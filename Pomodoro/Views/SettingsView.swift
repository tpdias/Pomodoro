//
//  SettingsView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

let alerts = ["vibration", "sound", "notification"]
let alertsBools = [false, false, false]

let timers = ["study", "break"]
let timersValue = [25.0 * 60, 5.0 * 60]

let sounds = ["none", "white", "brown", "black", "lofi", "rain", "forest", "wind"]

struct SettingsView: View {
    @State var curAlerts = [false, false, false]
    @State var curTimers = [false, false]
    @State var curSounds = [false, false, false, false, false, false, false, false]
    @Binding var visibility: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20)  {
                HStack {
                    Spacer()
                    
                        Button(action: {
                            visibility = false
                        }, label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.Gray3)
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.Gray5)
                            }
                        })
                }
                .padding(.horizontal, 24)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Alerts")
                        .font(
                            Font.custom("Noto Sans", size: 22)
                                .weight(.black)
                        )
                        .foregroundColor(Color.Primary)
                    
                    Text("choose how you want to be reminded.")
                        .font(Font.headline)
                        .foregroundColor(Color.Gray2)
                    HStack(alignment: .top, spacing: 16)  {
                        ForEach(0..<alerts.count){ index in
                            SettingsProperty(optionName: alerts[index], isOn: $curAlerts[index])
                                .onTapGesture {
                                    curAlerts[index].toggle()
                                }
                        }
                    }
                    .padding(0)
                }
                .padding(.bottom, 4)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Timers")
                        .font(
                            Font.custom("Noto Sans", size: 22)
                                .weight(.black)
                        )
                        .foregroundColor(Color.Secondary)
                    
                    Text("tap to change the time.")
                        .font(Font.custom("Noto Sans", size: 17))
                        .foregroundColor(Color.Gray2)
                    
                    
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0..<timers.count) { index in
                            TimerProperty(optionName: timers[index], isOn: $curTimers[index], time: timersValue[index])
                                .onTapGesture {
                                    curTimers[index].toggle()
                                }
                        }
                    }
                    .padding(0)
                    
                }
                
                VStack (alignment: .leading, spacing: 16) {
                    Text("Sounds")
                        .font(
                            Font.custom("Noto Sans", size: 22)
                                .weight(.black)
                        )
                        .foregroundColor(Color.Gray2)
                    
                    Text("choose the sound.")
                        .font(Font.custom("Noto Sans", size: 17))
                        .foregroundColor(Color.Gray2)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
                        ForEach(0..<sounds.count) { index in
                            SettingsSound(optionName: sounds[index], isOn: $curSounds[index])
                                .onTapGesture {
                                    curSounds =  Array(repeating: false, count: 8)
                                    curSounds[index].toggle()
                                }
                        }
                    }
                    .frame(alignment: .top)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 8)
                    
                } 
                
            }
            .padding(.horizontal, 32)
        }
        .ignoresSafeArea()
        .padding(.top, 40)


    }
}


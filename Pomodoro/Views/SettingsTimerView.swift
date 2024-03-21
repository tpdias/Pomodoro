//
//  SettingsTimer.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import SwiftUI

struct SettingsTimerView: View {
    @State var time: Double
    @State var color: Color
    @State var navigateToHome = false
    @State private var config: WheelPicker.Config = .init(count: times.count)
    var name: String
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.SecondBG
                        .edgesIgnoringSafeArea(.all)
                    WheelPicker(config: config, color: Color.Primary, value: $time)
                            .frame(height: geometry.size.height / 2)
                            .position(x: geometry.size.width - 50, y: geometry.size.height/2)
                    VStack(alignment: .center, spacing: 0) {
                        Text("change the \(name) time ")
                            .font(Font.title2())
                            .foregroundColor(color)
                        Text("scroll up and down to change")
                            .font(Font.body())
                            .foregroundColor(Color.Gray4)
                        
                        Spacer()
                        Button(action: {
                            navigateToHome = true
                        }, label: {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Done")
                                    .font(Font.title2Heavy())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.White)
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 13)
                            .background(color)
                            .cornerRadius(90)
                        })
                    }
                    .padding(32)
                    
                    VStack {
                        Spacer()
                        
                        TimerSmall(time: $time, color: $color)
                        
                        Spacer()
                    }
                    
                }
                .background(NavigationLink("", destination: HomeView(), isActive: $navigateToHome).hidden())
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct SettingsTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTimerView(time: 25.0 * 60, color: Color.Primary, name: "pause")
    }
}

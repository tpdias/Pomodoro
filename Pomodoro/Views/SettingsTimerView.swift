//
//  SettingsTimer.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import SwiftUI

struct SettingsTimerView: View {
    @State var pause: Bool = false
    var pauseTime = 5 * 60.0
    var pomoTime = 25 * 60.0
    @State var curColor = Color.Primary
    @State var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.SecondBG
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0) {
                    Text("change the Study time ")
                        .font(Font.title2())
                        .foregroundColor(curColor)
                    Text("scroll up and down to change")
                        .font(Font.body())
                        .foregroundColor(Color.Gray4)
                    
                    Spacer()
                    Button(action: {
                        if curColor == Color.SecondaryBG {
                            navigateToHome = true
                        } else {
                            curColor = Color.SecondaryBG
                        }
                    }, label: {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Done")
                                .font(Font.title2Heavy())
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.White)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 13)
                        .background(curColor)
                        .cornerRadius(90)
                    })
                }
                .padding(32)
                
                VStack {
                    Spacer()
                    
                    TimerSmall(time: pause ? pauseTime : pomoTime, color: $curColor)
                    
                    Spacer()
                }
            }
            .background(NavigationLink("", destination: HomeView(), isActive: $navigateToHome).hidden())
        }
        .navigationBarBackButtonHidden()
    }
}

struct SettingsTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTimerView()
    }
}

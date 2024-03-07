//
//  WatchHomeView.swift
//  PomodoroWatch Watch App
//
//  Created by Thiago Parisotto on 07/03/24.
//

import SwiftUI

struct WatchHomeView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: WatchTimerView(time: 25 * 60.0, pausedTimer: 5 * 60.0, cat: "Leo")) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.green)
                    Text("Start")
                        .font(Font.custom("NewNord-Extrabold", size: 24))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    WatchHomeView()
}

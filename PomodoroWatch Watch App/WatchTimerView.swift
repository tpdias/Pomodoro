//
//  WatchTimer.swift
//  PomodoroWatch Watch App
//
//  Created by Thiago Parisotto on 07/03/24.
//

import SwiftUI

struct WatchTimerView: View {
    @State var backColor: Color = Color.Primary
    @State var initialPauseTime: Double = 0
    @State var initialPomoTime: Double = 0
    var cat: String
    @State var textColor: Color = .white
        
    @StateObject var pomodoro = Pomodoro(timer: 25.0, tag: Tag(name: "Study", color: Color.Primary))

    @Environment(\.scenePhase) var scenePhase

    init(time: Double, initialPauseTime: Double, cat: String) {
        self.initialPomoTime = time
        self.initialPauseTime = initialPauseTime
        self.cat = cat
    }
    
    
    
    var body: some View {
        ZStack {
            Color(backColor)
                .ignoresSafeArea()
                
            VStack {
                ZStack {
                    VStack {
                        Spacer()
                        Text(String(format: "%02d:%02d", Int(pomodoro.timer) / 60, Int(pomodoro.timer) % 60))
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(textColor)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Image(systemName: "cat.fill")
                        //Image(cat)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .ignoresSafeArea()
                            .padding(.bottom, -50) //isso pode nao existir se a img for pela metade
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .onReceive(Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()) { _ in
            
            if !pomodoro.paused {
                if(pomodoro.curSesh%2 == 0) {
                    if pomodoro.timer > 0 {
                        pomodoro.decrement()
                    } else {
                        changeSesh()
                    }
                }
                else {
                    if pomodoro.timer > 0 {
                        pomodoro.decrement()
                    } else {
                        changeSesh()
                    }
                }
            } else {
                if(textColor == .white) {
                    textColor = .black
                } else {
                    textColor = .white
                }
            }
        }
        .onTapGesture {
            changePauseStatus()
        }
        .onAppear {
            
                self.pomodoro.syncDevice()
                if(pomodoro.curSesh%2 == 1) {
                    backColor = Color.SecondaryBG
                }
                if(!pomodoro.paused) {
                    textColor = .white
                }
            

        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                if(!pomodoro.paused) {
                    pomodoro.syncTime()
                    pomodoro.syncDevice()
                }
            } else if newPhase == .inactive {
                if(!pomodoro.paused) {
                    saveTime()
                }
            } else if newPhase == .background {
                if(!pomodoro.paused) {
                    saveTime()
                }
            }
            
        }
    }
    func saveTime() {
        let currentDate = Date()
        
        // Escrevendo a data atual no UserDefaults
        let sharedDefaults = UserDefaults(suiteName: appGroup)
        sharedDefaults?.set(currentDate, forKey: "exitDate")
        sharedDefaults?.synchronize()
    }
    
    
    func changeSesh() {
        pomodoro.incSesh()
        if(pomodoro.curSesh%2 == 0) {
            backColor = Color.Primary
            pomodoro.resetTimer(initialTime: initialPomoTime)
        } else {
            pomodoro.resetTimer(initialTime: initialPauseTime)
            backColor = Color.Secondary
        }

    }
    
    func changePauseStatus() {
        pomodoro.togglePause()
        textColor = .white
        if(pomodoro.paused) {
            NotificationManager.shared.stopNotification()
        } else {
            NotificationManager.shared.scheduleNotification(time: pomodoro.timer)
        }
        
    }
}


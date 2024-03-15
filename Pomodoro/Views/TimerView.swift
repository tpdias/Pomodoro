import SwiftUI
import UIKit

struct TimerView: View {
    @State var backColor: Color = Color.Primary
    @State var initialPauseTime: Double = 0
    @State var initialPomoTime: Double = 0
    var cat: Cat
    @State var textColor: Color = .white
    
    @StateObject var pomodoro = Pomodoro(timer: 25.0, tag: Tag(name: "Study", color: Color.Primary))
    
    @State var finished: Bool = false
    
    @Environment(\.scenePhase) var scenePhase
    
    init(time: Double, initialPauseTime: Double, cat: Cat) {
        self.initialPomoTime = time
        self.initialPauseTime = initialPauseTime
        self.cat = cat
        
        saveTime()
        
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                if(geometry.size.width > geometry.size.height) {
                    
                }
                ZStack {
                    Color(backColor)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        Text(String(format: "%02d:%02d", Int(pomodoro.timer) / 60, Int(pomodoro.timer) % 60))
                            .font(.system(size: 80))
                            .bold()
                            .foregroundColor(textColor)
                        Image(cat.image)
                            .resizable()
                            .frame(width: 300, height: 130)
                        Spacer()
                    }
                }
                .onReceive(Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()) { _ in
                    //notification update
                    if(NotificationManager.shared.continueSess) {
                        pomodoro.resetTimer(initialTime: 0)
                        NotificationManager.shared.continueSess = false
                        if((pomodoro.curSesh + 1 )%2 == 0) {
                            NotificationManager.shared.scheduleNotification(time: initialPomoTime)
                        } else {
                            NotificationManager.shared.scheduleNotification(time: initialPauseTime)
                        }
                    }
                    if(NotificationManager.shared.finished) {
                        finished = true
                        NotificationManager.shared.finished = false
                    }
                    if !pomodoro.paused {
                        if(pomodoro.curSesh%2 == 0) {
                            if pomodoro.timer > 0 {
                                pomodoro.decrement()
                                
                            } else {
                                pomodoro.resetTimer(initialTime: initialPomoTime)
                                changeSesh()
                            }
                        }
                        else {
                            if pomodoro.timer > 0 {
                                pomodoro.decrement()
                            } else {
                                pomodoro.resetTimer(initialTime: initialPauseTime)
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
            }
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            changePauseStatus()
        }
        .onAppear {
            // pomodoro.resetTimer(initialTime: initialPomoTime)
            NotificationManager.shared.scheduleNotification(time: initialPomoTime)
            self.pomodoro.syncDevice()
            if(pomodoro.curSesh%2 == 1) {
                backColor = Color.SecondaryBG
            }
            if(!pomodoro.paused) {
                textColor = .white
                
            }
        }
        .onChange(of: pomodoro.paused, perform: { newPause in
            print("switching")
            if(pomodoro.curSesh%2 == 1) {
                backColor = Color.SecondaryBG
            }
            if(!newPause) {
                textColor = Color.White
                
            }
        })
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                if(!pomodoro.paused) {
                    pomodoro.syncTime()
                }
            }
            
        }
#warning("mexer depois, nao consigo pelo simulador")
        
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
    
    
    
    func saveTime() {
        let currentDate = Date()
        
        // Escrevendo a data atual no UserDefaults
        let sharedDefaults = UserDefaults(suiteName: appGroup)
        sharedDefaults?.set(currentDate, forKey: "begginDate")
        sharedDefaults?.synchronize()
    }
    
    func savePauseTime() {
        let currentDate = Date()
        
        // Escrevendo a data atual no UserDefaults
        let sharedDefaults = UserDefaults(suiteName: appGroup)
        sharedDefaults?.set(currentDate, forKey: "begginPause")
        sharedDefaults?.synchronize()
    }
    
    
    func changePauseStatus() {
        
        pomodoro.togglePause()
        vibrate(with: .light)
        textColor = .white
        if(pomodoro.paused) {
            NotificationManager.shared.stopNotification()
        } else {
            NotificationManager.shared.scheduleNotification(time: pomodoro.timer)
            let sharedDefaults = UserDefaults(suiteName: appGroup)
                   guard let beginDate = sharedDefaults?.object(forKey: "beginDate") as? Date else {
                       return
                   }
                   let newBeginDate = Date().addingTimeInterval(pomodoro.timer + (initialPomoTime - pomodoro.timer))
                   
                   // Atualiza o tempo de início nos UserDefaults
                   sharedDefaults?.set(newBeginDate, forKey: "beginDate")
                   sharedDefaults?.synchronize()
                   
                 
        }
    }
    
}




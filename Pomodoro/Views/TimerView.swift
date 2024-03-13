import SwiftUI


struct TimerView: View {
    @State var backColor: String = "Primary"
    @State var initialPauseTime: Double = 0
    @State var initialPomoTime: Double = 0
    var cat: Cat
    @State var textColor: Color = .white
    
    @StateObject var pomodoro = Pomodoro(timer: 25.0, tag: Tag(name: "Study", color: "green"))
    @StateObject var sharedTimer = SharedTimer()

    @State var finished: Bool = false
    init(time: Double, initialPauseTime: Double, cat: Cat) {
        self.initialPomoTime = time
        self.initialPauseTime = initialPauseTime
        self.cat = cat
        
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.pomodoro.syncDevice()
                if(pomodoro.paused) {
                    backColor = "SecondaryBG"
                }
            }
        }
        #warning("mexer depois, nao consigo pelo simulador")
       
    }
    
    func changeSesh() {
        pomodoro.incSesh()
        if(pomodoro.curSesh%2 == 0) {
            backColor = "Primary"
            pomodoro.resetTimer(initialTime: initialPomoTime)
        } else {
            pomodoro.resetTimer(initialTime: initialPauseTime)
            backColor = "SecondaryBG"
        }

    }
    
    func changePauseStatus() {
        self.pomodoro.togglePause()
        vibrate(with: .light)
        textColor = .white
    }
    
}




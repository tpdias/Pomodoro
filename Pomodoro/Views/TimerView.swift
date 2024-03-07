import SwiftUI

struct TimerView: View {
    @State var pausedTimer: Double
    @State var paused: Bool = false
    @State var backColor: Color = .green
    @State var curSesh: Int = 0
    @State var initialPauseTime: Double = 0
    @State var initialPomoTime: Double = 0
    var cat: String
    @State var textColor: Color = .white
    
    @StateObject var pomodoro = Pomodoro(timer: 25 * 60, tag: Tag(name: "Study", color: "green"))

    init(time: Double, pausedTimer: Double, cat: String) {
        self.initialPomoTime = time
        self.cat = cat
        self.pausedTimer = pausedTimer
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
                        if(curSesh%2 == 1) {
                            Text(String(format: "%02d:%02d", Int(pausedTimer) / 60, Int(pausedTimer) % 60))
                                .font(.system(size: 80))
                                .bold()
                                .foregroundColor(textColor)
                        } else {
                            Text(String(format: "%02d:%02d", Int(pomodoro.timer) / 60, Int(pomodoro.timer) % 60))
                                .font(.system(size: 80))
                                .bold()
                                .foregroundColor(textColor)
                        }
                        Image(cat)
                            .resizable()
                            .frame(width: 300, height: 130)
                        Spacer()
                    }
                }
                .onReceive(Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()) { _ in
                    if !paused {
                        if(curSesh%2 == 0) {
                            if pomodoro.timer > 0 {
                               
                                pomodoro.decrement()
                            } else {
                                pomodoro.resetTimer(initialTime: initialPomoTime)
                                changeSesh()
                            }
                        }
                        else {
                            if pausedTimer > 0 {
                                pausedTimer -= 1
                            } else {
                                pausedTimer = initialPauseTime
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
            self.pomodoro.resetTimer(initialTime: initialPomoTime)
            self.initialPauseTime = pausedTimer
        }
    }
    
    func changeSesh() {
        vibrate(with: .light)
        curSesh += 1
        if(curSesh%2 == 0) {
            backColor = .green
        } else {
            backColor = .purple
        }
    }
    
    func changePauseStatus() {
        vibrate(with: .light)
        textColor = .white
        paused.toggle()
    }
    
}

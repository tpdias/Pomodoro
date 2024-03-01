import SwiftUI

struct TimerView: View {
    @Binding var timer: Double
    @Binding var paused: Bool 
    @State var backColor: Color = .white
    @State var textColor: Color = .black
    
    @State var progress: Double = 0
    let timerInterval: TimeInterval = 1.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                ZStack {
                    Color(backColor)
                        .ignoresSafeArea()
                        .onTapGesture {
                            if(paused) {
                                changePauseStatus()
                            }
                        }
                        .onLongPressGesture(minimumDuration: 1.5) {
                            if(!paused) {
                                changePauseStatus()
                            }
                        }
                    VStack {
                        Spacer()
                        Text(String(format: "%02d:%02d", Int(timer) / 60, Int(timer) % 60))
                            .font(.system(size: 80))
                            .bold()
                            .foregroundColor(textColor) // Cor do texto
                        Spacer()
                        if(!paused) {
                            HStack {
                                ProgressView(value: progress)
                                    .frame(width: geometry.size.width/2)
                            }
                        }
                        Spacer()
                    }
                }
                .onReceive(Timer.publish(every: timerInterval, on: .main, in: .common).autoconnect()) { _ in
                    if !paused {
                        if timer > 0 {
                            timer -= 1
                        } else {
                            timer = 25 * 60
                            paused.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func changePauseStatus() {
        vibrate(with: .light)
        if(paused) {
            textColor = .white
            backColor = .black
        }
        else {
            textColor = .black
            backColor = .white
        }
        paused.toggle()
    }
}

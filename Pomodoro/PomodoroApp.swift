//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 26/02/24.
//
import SwiftUI

@main
struct PomodoroApp: App {
    @State var timer: Double = 25.00 * 60
    @State var paused: Bool = true
    var body: some Scene {
        WindowGroup {
            TimerView(timer: $timer, paused: $paused)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    // Salvar dados no UserDefaults compartilhado com o app group
                    let sharedUserDefaults = UserDefaults(suiteName: appGroup)
                    sharedUserDefaults?.set(timer, forKey: "timer")
                    print(sharedUserDefaults?.value(forKey: "timer"))
                    // Enviar uma notificação para o NotificationCenter
                    NotificationCenter.default.post(name: Notification.Name("AppWillResignActive"), object: nil)
                }
        }
    }
}

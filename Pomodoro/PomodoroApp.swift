//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 26/02/24.
//
import SwiftUI

@main
struct PomodoroApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

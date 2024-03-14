//
//  NotificationManager.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 11/03/24.
//

import SwiftUI
import UserNotifications

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    @Published var finished: Bool = false
    @Published var continueSess: Bool = false
    
    enum NotificationAction {
        case FinishReminder
        case ContinueReminder
        
        var id: String {
            switch self {
            case .FinishReminder:
                return "finishReminder.doneAction"
            case .ContinueReminder:
                return "continueReminder.continueAction"
            }
        }
    }
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        requestAuthorization()
        registerCategories()
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if !granted {
                print("Notification permission denied")
            }
        }
    }
    
    func registerCategories() {
        let finishAction = UNNotificationAction(identifier: NotificationAction.FinishReminder.id, title: "Finish Session", options: [])
        let continueAction = UNNotificationAction(identifier: NotificationAction.ContinueReminder.id, title: "Continue Session", options: [])
        
        let pomodoroCategory = UNNotificationCategory(
            identifier: "pomodoroCategory",
            actions: [finishAction, continueAction],
            intentIdentifiers: [],
            options: .customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([pomodoroCategory])
    }
    
    func scheduleNotification(time: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro"
        content.body = "You finished a Session"
        content.sound = .default
        content.categoryIdentifier = "pomodoroCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "pomodoroCategory", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case NotificationAction.FinishReminder.id:
            finished = true
            continueSess = false
        case NotificationAction.ContinueReminder.id:
            continueSess = true
            finished = false
            break
        default:
            break
        }
        
        completionHandler()
    }
    
    func stopNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["pomodoroCategory"])
    }
}

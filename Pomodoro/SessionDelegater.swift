//
//  Counter.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 07/03/24.
//

import Foundation
import SwiftUI
import Combine
import WatchConnectivity

class SessionDelegater: NSObject, WCSessionDelegate {
    let curTimer: PassthroughSubject<Double, Never>
    let inPauseSubject: PassthroughSubject<Bool, Never>
    let curSeshSubject: PassthroughSubject<Int, Never>
    let pausedSubject: PassthroughSubject<Bool, Never>
    
    init(curTimer: PassthroughSubject<Double, Never>, inPauseSubject: PassthroughSubject<Bool, Never>, curSeshSubject: PassthroughSubject<Int, Never>, pausedSubject: PassthroughSubject<Bool, Never>) {
        self.curTimer = curTimer
        self.inPauseSubject = inPauseSubject
        self.curSeshSubject = curSeshSubject
        self.pausedSubject = pausedSubject
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let timer = message["timer"] as? Double {
                self.curTimer.send(timer)
            }
            if let inPause = message["inPause"] as? Bool {
                self.inPauseSubject.send(inPause)
            }
            if let curSesh = message["curSesh"] as? Int {
                self.curSeshSubject.send(curSesh)
            }
            if let paused = message["paused"] as? Bool {
                self.pausedSubject.send(paused)
            }
        }
    }
    
    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
}



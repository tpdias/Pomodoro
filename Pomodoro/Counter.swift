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
    let countSubject: PassthroughSubject<Int, Never>
    let curTimer: PassthroughSubject<Double, Never>
    
    init(countSubject: PassthroughSubject<Int, Never>, curTimer: PassthroughSubject<Double, Never>) {
        self.countSubject = countSubject
        self.curTimer = curTimer
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let count = message["count"] as? Int {
                self.countSubject.send(count)
            } else {
                print("There was an error")
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
final class Counter: ObservableObject {
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    let subjectTimer = PassthroughSubject<Double, Never>()
    
    @Published private(set) var count: Int = 0
    @Published private(set) var timer: Double = 0
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: subject, curTimer: subjectTimer)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
    }
    
    func increment() {
        count += 1
        session.sendMessage(["count": count], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    
    func decrement() {
        count -= 1
        session.sendMessage(["count": count], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func decrementTimer() {
        timer -= 1
        session.sendMessage(["timer": timer], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}


struct ContentView: View {
    @StateObject var counter = Counter()
    
    var labelStyle: some LabelStyle {
        #if os(watchOS)
        return IconOnlyLabelStyle()
        #else
        return DefaultLabelStyle()
        #endif
    }
    
    var body: some View {
        VStack {
            Text("\(counter.count)")
                .font(.largeTitle)
            
            HStack {
                Button(action: counter.decrement) {
                    Label("Decrement", systemImage: "minus.circle")
                }
                .padding()
                
                Button(action: counter.increment) {
                    Label("Increment", systemImage: "plus.circle.fill")
                }
                .padding()
            }
            .font(.headline)
            .labelStyle(labelStyle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

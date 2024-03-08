//
//  Pomodoros.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 07/03/24.
//

import Foundation
import UIKit
import WatchConnectivity
import Combine

class Pomodoro: ObservableObject {
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Double, Never>()
    
    @Published private(set) var timer: Double = 25 * 60
    
    private var cancellables = Set<AnyCancellable>()

    var tag: Tag
    var id = UUID()
    
    init(timer: Double, tag: Tag, session: WCSession = .default) {
        self.timer = timer
        self.tag = tag
        
        self.delegate = SessionDelegater(curTimer: subject)
                self.session = session
                self.session.delegate = self.delegate
                self.session.activate()
                
                subject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { newTimer in
                        // Check if the received timer is less than the current timer
                        if newTimer < self.timer {
                            // Update the timer only if the received timer is less
                            self.timer = newTimer
                        }
                    })
                    .store(in: &cancellables)
    }
    
    func decrement() {
        timer -= 1
        session.sendMessage(["timer": timer], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func resetTimer(initialTime: Double) {
        timer = initialTime
        session.sendMessage(["timer": timer], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}

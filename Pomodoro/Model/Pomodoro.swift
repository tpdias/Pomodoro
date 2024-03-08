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
    let inPauseSubject = PassthroughSubject<Bool, Never>()
    let curSeshSubject = PassthroughSubject<Int, Never>()
    let pausedSubject = PassthroughSubject<Bool, Never>()
    
    @Published private(set) var timer: Double = 25 * 60
    @Published private(set) var inPause: Bool = false
    @Published private(set) var curSesh: Int = 0
    @Published private(set) var paused: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    var tag: Tag
    var id = UUID()
    
    init(timer: Double, tag: Tag, session: WCSession = .default) {
        self.timer = timer
        self.tag = tag
        
        self.delegate = SessionDelegater(curTimer: subject, inPauseSubject: inPauseSubject, curSeshSubject: curSeshSubject, pausedSubject: pausedSubject)
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
                inPauseSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { newPause in
                        self.inPause = newPause
                    })
                    .store(in: &cancellables)
                curSeshSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { curSesh in
                        self.curSesh = curSesh
                    })
                    .store(in: &cancellables)
                pausedSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { paused in
                        self.paused = paused
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
    func togglePause() {
        if(paused){
            paused = false
        } else {
            paused = true
        }
        session.sendMessage(["paused": paused], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func toggleSeshPomo() {
        curSesh += 1
        if(inPause) {
            inPause = false
        } else {
            inPause = true
        }
        session.sendMessage(["inPause": inPause], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        session.sendMessage(["curSesh": curSesh], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}

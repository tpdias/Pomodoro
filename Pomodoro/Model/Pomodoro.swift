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
    let curSeshSubject = PassthroughSubject<Int, Never>()
    let pausedSubject = PassthroughSubject<Bool, Never>()
    let askSubject = PassthroughSubject<Bool, Never>()
    
    @Published private(set) var timer: Double = 25 * 60
    @Published private(set) var inPause: Bool = false
    @Published private(set) var curSesh: Int = 0
    @Published private(set) var paused: Bool = false
    
    @Published private(set) var askSync: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    var tag: Tag
    var id = UUID()
    
    init(timer: Double, tag: Tag, session: WCSession = .default) {
        self.timer = timer
        self.tag = tag
        
        self.delegate = SessionDelegater(curTimer: subject, curSeshSubject: curSeshSubject, pausedSubject: pausedSubject, askSyncSubject: askSubject)
                self.session = session
                self.session.delegate = self.delegate
                self.session.activate()
                
                subject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { newTimer in
                        self.timer = newTimer
                    })
                    .store(in: &cancellables)           
                curSeshSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { curSesh in
                        print("Cur sesh \(curSesh)")
                        self.curSesh = curSesh
                    })
                    .store(in: &cancellables)
                pausedSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { paused in
                        print(paused)
                        self.paused = paused
                    })
                    .store(in: &cancellables)
        
                askSubject
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { syncAsked in
                        self.askSync = syncAsked
                        self.sendData()
                    })
                    .store(in: &cancellables)
        
        self.syncDevice()
    }
    
    func sendData() {
        let timerData = NSNumber(value: timer)
        let curSeshData = NSNumber(value: curSesh)
        let pausedData = NSNumber(value: paused)
        session.sendMessage(["timer": timerData], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        session.sendMessage(["curSesh": curSeshData], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        session.sendMessage(["paused": pausedData], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func togglePause() {
        if(paused){
            paused = false
        } else {
            paused = true
        }
        let pausedData = NSNumber(value: paused)
        session.sendMessage(["paused": pausedData], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func syncDevice() {
        print("synching")
        let asyncData = NSNumber(value: askSync)
        session.sendMessage(["askSync": asyncData], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    func decrement() {
        timer -= 1
    }
    func resetTimer(initialTime: Double) {
        timer = initialTime
    }
    func incSesh() {
        curSesh += 1
    }
//    func decrement() {
//        timer -= 1
//        session.sendMessage(["timer": timer], replyHandler: nil) { error in
//            print(error.localizedDescription)
//        }
//        let sharedDefaults = UserDefaults(suiteName: appGroup)
//               sharedDefaults?.set(timer, forKey: "timer")
//               sharedDefaults?.synchronize()
//               
//               // Envie uma mensagem para a sessão do WatchConnectivity (se necessário)
//               session.sendMessage(["timer": timer], replyHandler: nil) { error in
//                   print(error.localizedDescription)
//               }
//    }
    
//    func resetTimer(initialTime: Double) {
//        timer = initialTime
//        session.sendMessage(["timer": timer], replyHandler: nil) { error in
//            print(error.localizedDescription)
//        }
//    }
 
//    func toggleSeshPomo() {
//        curSesh += 1
//        if(inPause) {
//            inPause = false
//        } else {
//            inPause = true
//        }
//        session.sendMessage(["inPause": inPause], replyHandler: nil) { error in
//            print(error.localizedDescription)
//        }
//        session.sendMessage(["curSesh": curSesh], replyHandler: nil) { error in
//            print(error.localizedDescription)
//        }
//    }
}

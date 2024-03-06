//
//  WatchToIOSConnector.swift
//  PomodoroWatch Watch App
//
//  Created by Thiago Parisotto on 05/03/24.
//

import Foundation
import Combine
import WatchConnectivity

class WatchToIOSConnector: NSObject, WCSessionDelegate {
 
    
    let countSubject: PassthroughSubject<Int, Never>
    
    init(countSubject: PassthroughSubject<Int, Never>) {
        self.countSubject = countSubject
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let count = message["count"] as? Int {
                self.countSubject.send(count)
            } else {
                print("There was an error")
            }
        }
    }

}

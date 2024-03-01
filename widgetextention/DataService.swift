//
//  DataService.swift
//  widgetextentionExtension
//
//  Created by Thiago Parisotto on 01/03/24.
//

import Foundation
import SwiftUI
let appGroup = "group.com.tpdias.Pomodoro"
struct DataService {
    @AppStorage("timer", store: UserDefaults(suiteName: appGroup)) private var timer = 25.00 * 60
    
    func decreaseTime() {
        timer -= 1
        if(timer == 0) {
            timer = 25 * 60
        }
    }
    func progress() -> Double {
        let sharedUserDefaults = UserDefaults(suiteName: appGroup)
        if let timer = sharedUserDefaults?.value(forKey: "timer") as? Double {
            print(timer)
            return timer
        }
        return timer
    }
    
}

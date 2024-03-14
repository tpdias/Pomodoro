//
//  Fonts.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 14/03/24.
//

import Foundation
extension Font {
    static func largeTitleFont() -> Font {
        return Font.custom("", size: 120)
            .weight(.bold)
    }
    
}

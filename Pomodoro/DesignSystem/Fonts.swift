//
//  Fonts.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 14/03/24.
//

import Foundation
import SwiftUI

extension Font {
    //Noto Sans
    
    static func largeTitle() -> Font {
        return Font.custom("Noto Sans", size: 120)
            .weight(.black)
    }
    
    static func title1() -> Font {
        return Font.custom("Noto Sans", size: 28)
            .weight(.heavy)
    }
    
    static func title2() -> Font {
        return Font.custom("Noto Sans", size: 22)
            .weight(.bold)
    }
    
    static func title2Heavy() -> Font {
        return Font.custom("Noto Sans", size: 28)
            .weight(.black)
    }
    
    static func title3() -> Font {
        return Font.custom("Noto Sans", size: 20)
            .weight(.bold)
    }
    
    static func headline() -> Font {
        return Font.custom("Noto Sans", size: 24)
            .weight(.semibold)
    }
    
    static func heading() -> Font {
        return Font.custom("Noto Sans", size: 20)
            .weight(.semibold)
    }
    
    static func body() -> Font {
        return Font.custom("Noto Sans", size: 17)
            .weight(.regular)
    }
    
    static func bodyBody() -> Font {
        return Font.custom("Noto Sans", size: 17)
            .weight(.bold)
    }
    
    static func callout() -> Font {
        return Font.custom("Noto Sans", size: 16)
            .weight(.regular)
    }
    
    static func subhead() -> Font {
        return Font.custom("Noto Sans", size: 15)
            .weight(.regular)
    }
    
    static func footnote() -> Font {
        return Font.custom("Noto Sans", size: 13)
            .weight(.regular)
    }
    
    static func tag() -> Font {
        return Font.custom("Noto Sans", size: 17)
            .weight(.semibold)
    }

    static func notificationTitle() -> Font {
        return Font.custom("Noto Sans", size: 15)
            .weight(.semibold)
    }
    
    //Londrina
    
    static func timerButton() -> Font {
        return Font.custom("Londrina Solid", size: 24)
            .weight(.light)
    }
    
    static func stats() -> Font {
        return Font.custom("Londrina Solid", size: 50)
            .weight(.black)
    }

    static func timer() -> Font {
        return Font.custom("Londrina Solid", size: 120)
            .weight(.regular)
    }
    
    static func smallTimer() -> Font {
        return Font.custom("Londrina Solid", size: 80)
            .weight(.regular)
    }
    
    static func numberSlider() -> Font {
        return Font.custom("Londrina Solid", size: 25)
            .weight(.black)
    }
    
}

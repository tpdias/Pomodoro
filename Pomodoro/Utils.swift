//
//  Utils.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 26/02/24.
//

import Foundation
import UIKit


enum HapticFeedbackStrength {
    case light
    case medium
    case heavy
    case soft
    case rigid

    // Método para obter o estilo correspondente ao nível de força
    fileprivate var style: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light, .soft:
            return .light
        case .medium:
            return .medium
        case .heavy, .rigid:
            return .heavy
        }
    }
}

// Função de vibração com força customizada
func vibrate(with strength: HapticFeedbackStrength) {
    if #available(iOS 10.0, *) {
        let generator = UIImpactFeedbackGenerator(style: strength.style)
        generator.impactOccurred()
    }
}

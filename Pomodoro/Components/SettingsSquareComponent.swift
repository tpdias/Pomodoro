//
//  SettingsSquareComponent.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

struct SettingsSquareComponent: View {
    var title: String
    var backColor: String
    var description: String?
    
    init(title: String, backColor: String, description: String? = nil) {
        self.title = title
        self.backColor = backColor
        self.description = description
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray)
            VStack{
                Spacer()
                if let description {
                    Text(description)
                        .font(Font.custom("NewNord-Regular", size: 13))
                        .foregroundStyle(.black)
                    Spacer()
                }
                Text(title)
                    .font(Font.custom("NewNord-Semibold", size: 20))
                    .foregroundStyle(.black)
            }
        }.frame(width: 100, height: 100)
    }
}

#Preview {
    SettingsSquareComponent(title: "study", backColor: "Gray")
}

//
//  CatView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 10/03/24.
//

import SwiftUI

struct CatView: View {
    var isSelected: Bool
    var cat: Cat
    @State var textColor: String = "Black3"
    @State var squareBG: String = "Gray5"
    @State var subtitleColor: String = "Gray2"
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 170, height: 240)
                .foregroundColor(Color(squareBG))
            VStack {
                Image(cat.image)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
               
                Text(cat.name)
                    .foregroundStyle(Color(textColor))
                    .font(Font.custom("NewNord-Bold", size: 20))
                Text(cat.subtitle)
                    .foregroundStyle(Color(subtitleColor))
                    .font(Font.custom("NewNord-Regular", size: 15))
        
            }
                
        }
        .onAppear {
            if(isSelected) {
                self.textColor = "White"
                self.subtitleColor = "SecondBG"
            }
        }
    }
}

#Preview {
    CatView(isSelected: false, cat: cats[0])
}

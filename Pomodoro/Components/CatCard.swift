//
//  CatView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 10/03/24.
//

import SwiftUI

struct CatCard: View {
    var isSelected: Bool
    var cat: Cat
    @State var textColor: Color = Color.black3
    @State var squareBG: Color = Color.gray5
    @State var subtitleColor: Color = Color.gray2
    var body: some View {
        ZStack{
            
            VStack(alignment: .center, spacing: 4) {
                ZStack {
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 150, height: 150)
                    .background(Color.MainBG)
                    .cornerRadius(50)
                    
                    Image(cat.image)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .padding(.bottom, 4)
                }
                Text(cat.name)
                    .font(
                        Font.custom("Noto Sans", size: 20)
                            .weight(.bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .padding(.bottom, 8.5)
                Text(cat.subtitle)
                    .font(Font.custom("Noto Sans", size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(subtitleColor)
                    .padding(.bottom, 8.5)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 9)
            .background(squareBG)
            .cornerRadius(50)
            .frame(width: 170, height: 240)
                
        }
        .onAppear {
            if(isSelected) {
                self.textColor = Color.White
                self.subtitleColor = Color.secondBG
                self.squareBG = Color.Black2
            }
        }
    }
}

#Preview {
    CatCard(isSelected: false, cat: cats[0])
}

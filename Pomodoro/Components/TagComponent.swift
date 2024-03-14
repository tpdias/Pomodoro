//
//  Tag.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 13/03/24.
//

import SwiftUI

struct TagComponent: View {
    var name: String
    var color: Color
    var isOn: Bool
    var isSelected: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 160, height: 80)
                .background(isOn ? Color.Primary : Color.White)
                .cornerRadius(90)
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    HStack(){
                        Image(systemName: "circle.fill")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(isOn ? Color.White : color)
                            .padding(12)
                        Spacer()
                    }
                    Text(name)
                        .font(
                            Font.custom("Noto Sans", size: 17)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(isOn ? Color.White : Color.Black3)
                }
            }
            if(isSelected) {
                HStack {
                    Spacer()
                    VStack{
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.BrandRed)
                        Spacer()
                    }
                }
            }
        }
        .frame(width: 160, height: 80)
    }
}

#Preview {
    TagComponent(name: "focus", color: Color.Primary, isOn: false, isSelected: false)
}

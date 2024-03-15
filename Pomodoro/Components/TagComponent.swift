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
    @Binding var showingDeleteAlert: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 160, height: 80)
                .background(isOn ? color : Color.White)
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
                        .foregroundColor(isOn ? Color.MainBG : Color.Black3)
                }
            }
            if(isSelected) {
                HStack {
                    Spacer()
                    VStack{
                        ZStack {
                            
                          
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.White)
                            
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.BrandRed)
                                .onTapGesture {
                                    showingDeleteAlert = true
                                }
                        }
                        
                        Spacer()
                            
                    }
                }
            }
        }
        .frame(width: 160, height: 80)
    }
}

//
//  NewTagComponent.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 14/03/24.
//

import SwiftUI

struct NewTagComponent: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 160, height: 80)
                .background(Color.Gray4)
                .cornerRadius(90)
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    HStack(){
                        Image(systemName: "plus.circle.fill")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.MainBG)
                            .padding(12)
                        Spacer()
                    }
                    Text("new tag")
                        .font(
                            Font.custom("Noto Sans", size: 17)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.MainBG)
                }
            }
        }
        .frame(width: 160, height: 80)
    }
}

//
//  OptionView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 11/03/24.
//

import SwiftUI

struct SettingsProperty: View {
    var optionName: String
    @Binding var isOn: Bool
   
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 100)
                .background(isOn ? Color.Primary : Color.Gray5)
                .cornerRadius(30)
                VStack {
                    Spacer()
                    Text(optionName)
                        .font(Font.custom("Noto Sans", size: 13))
                        .multilineTextAlignment(.center)
                        .foregroundColor(isOn ? Color.MainBG: Color.Black2)
                        .frame(width: 100, alignment: .top)
                }
                .padding(.vertical, 7)
            
        }
        .frame(width: 100, height: 100)
        
        
    }
}


struct SettingsProperty_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProperty(optionName: "Option 1", isOn: .constant(true))
    }
}

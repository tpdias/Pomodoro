//
//  SettingsView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Alerts")
                .font(Font.custom("NewNord-Bold", size: 22))
                .foregroundStyle(Color(red: 0.48, green: 0.70, blue: 0.55))
            Text("choose how you want to be reminded.")
              .font(Font.custom("NewNord-Regular", size: 17))
              .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
        }
    }
}

#Preview {
    SettingsView()
}

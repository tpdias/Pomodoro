//
//  ChooseCats.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 10/03/24.
//

import SwiftUI

struct ChooseCats: View {
    var body: some View {
        Text("Cat Companions")
            .font(Font.custom("NewNord-Bold", size: 20))
            .foregroundStyle(Color("Black2"))
        Text("Choose your focus companion.")
            .font(Font.custom("NewNord-Regular", size: 17))
            .foregroundStyle(Color("Gray2"))
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(cats, id: \.name) { cat in
                    CatView(isSelected: false, cat: cat)
                        .padding()
                }
            }
    }
}

#Preview {
    ChooseCats()
}

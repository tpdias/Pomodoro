//
//  ChooseCats.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 10/03/24.
//

import SwiftUI

struct ChooseCatsView: View {
    @Binding var selectedCat: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Cat Companions")
                .font(
                Font.custom("Noto Sans", size: 22)
                .weight(.black)
                )
                .foregroundColor(Color.Black2)

                Text("choose your focus companion.")
                .font(Font.custom("Noto Sans", size: 17))
                .foregroundColor(Color.Gray2)
            }
            .padding(0)
            .padding(.horizontal, 28)
            
            HStack(alignment: .top, spacing: 0) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<cats.count) { index in
                        if(selectedCat == index) {
                            CatCard(isSelected: true, cat: cats[index])
                                .frame(width: 170, height: 240)
                        } else {
                            CatCard (isSelected: false, cat: cats[index])
                                .frame(width: 170, height: 240)
                                .onTapGesture {
                                    selectedCat = index
                                }
                        }
                    }
                }
            }
            .padding(15)
            .frame(alignment: .topLeading)
        }
        
    }
}
struct ChooseCatsView_Previews: PreviewProvider {
    static var previews: some View {
        // Aqui você pode definir diferentes valores para selectedCat, se necessário
        let selection = Binding.constant(0)
        
        return ChooseCatsView(selectedCat: selection)
    }
}

 

//
//  ChooseCats.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 10/03/24.
//

import SwiftUI

struct ChooseCatsView: View {
    @Binding var selectedCat: Int
    @Binding var visibility: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    
                        Button(action: {
                            visibility = false
                        }, label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.Gray3)
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.Gray5)
                            }
                        })
                }
                .padding(.horizontal, 24)
                
                VStack(alignment: .leading, spacing: 4) {
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
                .padding(.bottom, 40)
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
        .ignoresSafeArea()
        .padding(.top, 40)

    }
}


//
//  TagsView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

var curTags = [
    Tag(name: "focus", color: Color.Primary),
    Tag(name: "study", color: Color.Secondary),
    Tag(name: "work", color: Color.Terciary),
    Tag(name: "read", color: Color.BrandBlue),
    Tag(name: "workout", color: Color.BrandRed)
]
struct TagsView: View {
    @State var currentTag = 0
    @State var selectedTag = -1
    var body: some View {
        VStack (alignment: .leading, spacing: 32){
            Text("Select the Tag")
                .font(
                    Font.custom("Noto Sans", size: 20)
                        .weight(.bold)
                )
                .foregroundColor(Color.Black2)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(0..<curTags.count) { index in
                    let tag = curTags[index]
                    let isSelected = index == selectedTag
                    let isOn = index == currentTag
                    TagComponent(name: tag.name, color: tag.color, isOn: isOn, isSelected: isSelected)
                        .onTapGesture {
                            currentTag = index
                            selectedTag = -1
                        }
                        .onLongPressGesture {
                            selectedTag = index
                        }
                }
                
            }
            .padding(0)
            .frame(width: 337, alignment: .topLeading)
            
        }
        .ignoresSafeArea()
    }
}

extension Array {
    func chunks(of size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { startIndex in
            let endIndex = Swift.min(startIndex + size, count)
            return Array(self[startIndex ..< endIndex])
        }
    }
}

#Preview {
    TagsView()
}

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
    @Binding var visibility: Bool
    @State var showingAlert = false
    @State private var name = ""
    @State var showingDeleteAlert = false
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 32){
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
                        TagComponent(name: tag.name, color: tag.color, isOn: isOn, isSelected: isSelected, showingDeleteAlert: $showingDeleteAlert)
                            .onTapGesture {
                                currentTag = index
                                selectedTag = -1
                            }
                            .onLongPressGesture {
                                selectedTag = index
                            }
                    }
                    NewTagComponent()
                        .onTapGesture {
                            showingAlert = true
                        }
                    
                }
                .padding(0)
                .frame(width: 337, alignment: .topLeading)
            }
            .ignoresSafeArea()
            .padding(.top, 40)
            .padding(.horizontal, 32)

        }
        .alert("Create a new Tag", isPresented: $showingAlert, actions: {
                    TextField("Name", text: $name)
                    
                    Button("Create", action: {
                        print(name)
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Write the name of the activity you will focus on.")
                })
        .alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete Tag"), message: Text("Are you sure you want to delete this tag? Removing it will also delete associated data"), primaryButton: .destructive(Text("Delete")), secondaryButton: .cancel())
        })
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



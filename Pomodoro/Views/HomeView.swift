//
//  HomeView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

struct HomeView: View {
    var pomoTime: Double
    var pomoPauseTimer: Double
    @State var selectedCat: Int
    var tag: String
    var tagColor: String
    @State var settingsSheet: Bool = false
    @State var tagSheet: Bool = false
    @State var catSheet: Bool = false
        
    init() {
        self.selectedCat = 0
        self.pomoTime = 25.0
        self.pomoPauseTimer = 5.0
        self.tag = "study"
        self.tagColor = "BrandBlue"
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(Color("MainBG"))
                VStack {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: 50.00, height: 50.00)
                    
                    //Tag info
                    HStack(alignment: .center, spacing: 0) {
                        Text(String(format: "%02d:%02d", Int(pomoTime) / 60, Int(pomoTime) % 60))
                            .font(Font.custom("Londrina Solid", size: 100))
                            .kerning(4.8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.Black2)
                    }
                        .padding(.horizontal, 1)
                        .padding(.vertical, 0)
                        .frame(width: 289, height: 108, alignment: .center)
                    HStack{
                        Spacer()
                        Circle()
                            .foregroundStyle(Color(tagColor))
                            .frame(width: 20)
                        Text(tag)
                            .font(Font.custom("NewNord-Bold", size: 28))
                            .foregroundColor(Color("Gray4"))
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("Gray4"))
                        Spacer()
                    }
                    .onTapGesture {
                        self.tagSheet = true
                    }
                    .padding(.horizontal, 10)
                    VStack(alignment: .center, spacing: 24) {
                        //cat image
                        Image(cats[selectedCat].image)
                            .resizable()
                            .frame(width: 290, height: 290)
                            .onTapGesture {
                                catSheet = true
                            }
                        
                        NavigationLink(destination: TimerView(time: pomoTime, initialPauseTime: pomoPauseTimer, cat: cats[selectedCat]), label: {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Start")
                                    .font(
                                        Font.custom("Noto Sans", size: 28)
                                            .weight(.heavy)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.White)
                                
                                
                                
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 13)
                            .background(Color.Primary)
                            .cornerRadius(90)
                        })
                        HStack{
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 50.00, height: 50.00)
                            Spacer()
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 50.00, height: 50.00)
                                .onTapGesture {
                                    settingsSheet = true
                                }
                        }.padding(.horizontal, 50)
                    }
                }
            }
        }
        .sheet(isPresented: $settingsSheet, content: {
            SettingsView()
                .background(Color.MainBG)
        })
        .sheet(isPresented: $tagSheet, content: {
            TagsView()
                .background(Color.MainBG)
        })
        .sheet(isPresented: $catSheet, content: {
            ChooseCatsView(selectedCat: $selectedCat)
                .background(Color.MainBG)
        })
    }
}

#Preview {
    HomeView()
}

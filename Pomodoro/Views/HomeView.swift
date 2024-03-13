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
                    Text(String(format: "%02d:%02d", Int(pomoTime) / 60, Int(pomoTime) % 60))
                        .font(Font.custom("NewNord-Extrabold", size: 90))
                        .foregroundColor(Color("Black2"))
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
                    
                    //cat image
                    Image(cats[selectedCat].image)
                        .resizable()
                        .frame(width: 290, height: 290)
                        .onTapGesture {
                            catSheet = true
                        }
                    
                    NavigationLink(destination: TimerView(time: pomoTime, initialPauseTime: pomoPauseTimer, cat: cats[selectedCat]), label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 90)
                                .foregroundStyle(Color("Primary"))
                                .frame(width: 160, height: 75)
                            Text("Start")
                                .font(Font.custom("NewNord-Bold", size: 28))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                        }
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
        .sheet(isPresented: $settingsSheet, content: {
            SettingsView()
                //.presentationDetents([.medium])
        })
        .sheet(isPresented: $tagSheet, content: {
            TagsView()
        })
        .sheet(isPresented: $catSheet, content: {
            ChooseCatsView(selectedCat: $selectedCat)
        })
    }
}

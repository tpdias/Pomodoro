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
    var tag: String
    var tagColor: String
    var curCat: String
    @State var settingsSheet: Bool = false
    @State var tagSheet: Bool = false
    
    init() {
        self.pomoTime = 25.0
        self.pomoPauseTimer = 5.0
        self.tag = "study"
        self.tagColor = "Blue"
        self.curCat = "Leo"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.white)
                VStack {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: 50.00, height: 50.00)
#warning("colocar fonte do app aqui")
                    Text(String(format: "%02d:%02d", Int(pomoTime) / 60, Int(pomoTime) % 60))
                        .font(Font.custom("NewNord-Extrabold", size: 90))
                        .foregroundColor(.black)
                    HStack{
                        Spacer()
                        Circle()
                            .foregroundStyle(.blue/*Color(tagColor)*/)
                            .frame(width: 20)
                        Text(tag)
                            .font(Font.custom("NewNord-Bold", size: 28))
                            .foregroundColor(.black)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .onTapGesture {
                        self.tagSheet = true
                    }
                    .padding(.horizontal, 10)
                    Image(curCat)
                        .resizable()
                        .frame(width: 290, height: 290)
                    NavigationLink(destination: TimerView(time: pomoTime, pausedTimer: pomoPauseTimer, cat: curCat), label: {
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
        })
        .sheet(isPresented: $tagSheet, content: {
            TagsView()
        })
    }
}

#Preview {
    HomeView()
}

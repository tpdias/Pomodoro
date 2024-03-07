//
//  OnboardingView.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 06/03/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                OnboardingPage(title: "Tela 1", text: "Esta é a tela 1", imageName: "1")
                    .tag(0)
                OnboardingPage(title: "Tela 2", text: "Esta é a tela 2", imageName: "2")
                    .tag(1)
                OnboardingPage(title: "Tela 3", text: "Esta é a tela 3", imageName: "3")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // PageControl embedded directly within OnboardingView
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(index == currentPage ? .blue : .gray)
                }
            }
            .padding()
        }
    }
}



struct OnboardingPage: View {
    var title: String
    var text: String
    var imageName: String
        
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text(text)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal, 20)
        }
        .padding(.horizontal, 20)
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

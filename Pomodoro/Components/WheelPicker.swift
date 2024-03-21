//
//  WheelPicker.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 15/03/24.
//

import SwiftUI
import SwiftUI


var times = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]


struct WheelPicker: View {
    var config: Config
    var color: Color
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let verticalPadding = size.height / 2
            HStack {
                Spacer()
                ScrollView(.vertical) {
                    
                    VStack(spacing: config.spacing) {
                        let totalSteps = config.steps * config.count
                        ForEach(1...totalSteps, id: \.self) { index in
                            let remainder = index % config.steps
                            
                            Divider()
                                .background(remainder == 0 ? Color.Black2 : Color.Gray3)
                                .frame(width: remainder == 0 ? 20 : 10, height: 6, alignment: .trailing)
                            // .frame(maxHeight: 30, alignment: .trailing)
                                .overlay(alignment: .trailing) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .foregroundColor(Color.Gray4)
                                            .frame(width: remainder == 0 ? 30 : 15, height: 6)
                                        
                                        if remainder == 0 && config.showsText {
                                            Text("\(times[times.count - (index / config.steps)])")
                                                .font(
                                                Font.custom("Londrina Solid", size: 25)
                                                .weight(.black)
                                                )
                                                .kerning(1)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color.Gray4)
                                                .offset(x: -40)
                                        }
                                    }
                                }
                        }
                    }
                    .frame(width: size.width)
                    .scrollTargetLayout()
                    
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: .init(get: {
                    let position: Int = Int(value)
                    return position
                }, set: { newValue in
                    if let newValue {
                        value = Double((times[times.count - 1] - newValue) * 60)
                    }
                }))
                .overlay(alignment: .center) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 36, height: 8)
                            .font(.caption)
                            .foregroundStyle(color)
                            .fontWeight(.semibold)
                            .textScale(.secondary)
                            .fixedSize()
                            .offset(x: -20)
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .frame(width: 28, height: 27)
                            .foregroundStyle(color)
                            .rotationEffect(Angle(degrees: -90))
                            .offset(x: 20)
                    }
                }
                .safeAreaPadding(.vertical, verticalPadding)
            }
        }
    }
    
    struct Config: Equatable {
        var count: Int
        var steps: Int = 5
        var spacing: CGFloat = 10
        var showsText: Bool = true
    }
}

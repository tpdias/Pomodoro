//
//  Cat.swift
//  Pomodoro
//
//  Created by Thiago Parisotto on 07/03/24.
//

import Foundation

var cats: [Cat] = [
    Cat(name: "Leo", subtitle: "Big cat", image: "Leo"),
    Cat(name: "Yumi", subtitle: "Small cat", image: "Leo"),
    Cat(name: "Josh", subtitle: "Funky cat", image: "Leo"),
    Cat(name: "Berg", subtitle: "Just a cat", image: "Leo")
]
class Cat {
    var name: String
    var subtitle: String
    var image: String
    
    init(name: String, subtitle: String, image: String) {
        self.name = name
        self.subtitle = subtitle
        self.image = image
    }
}

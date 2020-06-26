//
//  Ramen.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

class Ramen: ObservableObject, Identifiable {
    var id: String = ""
    var brand: String = ""
    var name: String = ""
    var style: String = ""
    var image: String = ""
    var searchableName: String = ""
    @Published var averageStars: Int = 0
    var spiciness: Int = 0
    @Published var reviews: [String] = []

    enum Style: String, CaseIterable, Codable {
        case packet = "Packet"
        case cup = "Cup"
        case tray = "Tray"
        case bowl = "Bowl"
    }
    
    init(id: String, brand: String, name: String, style: String, image: String, searchableName: String, averageStars: Int, spiciness: Int, reviews: [String]) {
        self.id = id
        self.brand = brand
        self.name = name
        self.style = style
        self.image = image
        self.reviews = reviews
        self.searchableName = brand + name + style
        self.spiciness = spiciness
    }

    init(){}
}

//extension Ramen {
//    var imageUsed: Image {
//        ImageStore.shared.image(name: image)
//    }
//}

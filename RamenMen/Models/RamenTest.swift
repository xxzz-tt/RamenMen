//
//  RamenTest.swift
//  RamenMen
//
//  Created by X ZZ on 23/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import Combine
import SwiftUI

class RamenTest : ObservableObject {
        var id: Int = 0
        var brand: String = "Nissin"
        var name: String = "Chicken Noodle"
        var style: Style = Style.bowl
        var image: Image = Image("nissin")
        @Published var reviews: [ReviewTest] = []
        
        enum Style: String, CaseIterable, Codable {
            case packet = "Packet"
            case cup = "Cup"
            case tray = "Tray"
            case bowl = "Bowl"
        }
    
    init(id: Int, brand: String, name: String, style: Style, image: Image, reviews: [ReviewTest]? = []) {
        self.id = id
        self.brand = brand
        self.name = name
        self.style = style
        self.image = image
        self.reviews = reviews!
    }
    
    init(){}
}


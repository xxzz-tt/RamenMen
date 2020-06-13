//
//  Ramen.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct Ramen: Codable {
    var id: Int
    var brand: String
    var name: String
    var style: Style
    var image: String
//    var reviews: [Review]
    
    enum Style: String, CaseIterable, Codable {
        case packet = "Packet"
        case cup = "Cup"
        case tray = "Tray"
        case bowl = "Bowl"
    }
}

//extension Ramen {
//    var imageUsed: Image {
//        ImageStore.shared.image(name: image)
//    }
//}

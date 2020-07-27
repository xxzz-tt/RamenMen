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
    @Published var star: Float = 0
    var spiciness: Float = 0
    var value: Float = 0
    @Published var reviews: [String] = []

    enum Style: String, CaseIterable, Codable {
        case packet = "Packet"
        case cup = "Cup"
        case tray = "Tray"
        case bowl = "Bowl"
    }
    
    init(id: String, brand: String, name: String, style: String, image: String, searchableName: String, star: Float, spiciness: Float, reviews: [String]) {
        self.id = id
        self.brand = brand
        self.name = name
        self.style = style
        self.image = image
        self.reviews = reviews
        self.searchableName = brand + " " + name +  " " + style
        self.spiciness = spiciness
        self.star = star

    }
    
    init(id: String, brand: String, name: String, style: String, image: String, searchableName: String, star: Float, spiciness: Float, value: Float, reviews: [String]) {
        self.id = id
        self.brand = brand
        self.name = name
        self.style = style
        self.image = image
        self.reviews = reviews
        self.searchableName = brand + " " + name + " " + style
        self.spiciness = spiciness
        self.star = star
        self.value = value

    }
    private func math(oldbase: Float, oldstar: Float, star: Float) -> Float {
        return (oldbase * oldstar + star) / (oldbase + 1)
    }
    func addReview(review: Review) {
        self.star = math(oldbase: Float(self.reviews.count), oldstar: self.star, star: Float(review.star))
        self.value = math(oldbase: Float(self.reviews.count), oldstar: self.value, star: Float(review.value))
        self.spiciness = math(oldbase: Float(self.reviews.count), oldstar: self.spiciness, star: Float(review.spiciness))
        self.reviews.append(review.id)
    }

    init(){}
}

//extension Ramen {
//    var imageUsed: Image {
//        ImageStore.shared.image(name: image)
//    }
//}

struct Ramen_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

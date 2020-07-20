//
//  User.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Identifiable {
    var id: String = ""
    @Published var username: String = ""
    var password: String = ""
    @Published var image: String = ""
    @Published var reviews: [String] = []
    
    init(id: String, username: String, password: String, image: String, reviews: [String]) {
        self.id = id
        self.username = username
        self.password = password
        self.image = image
        self.reviews = reviews
    }
    
    init(){}
    
    func addReview(review: Review) {
        self.reviews.append(review.id)
    }
}

//extension User {
//    var imageUsed: Image {
//        ImageStore.shared.image(name: image)
//    }
//}

//
//  UserTest.swift
//  RamenMen
//
//  Created by X ZZ on 23/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import Combine
import SwiftUI

class UserTest : ObservableObject {
    var id: Int = 0
    var username: String = "mehehe"
    var password: String = ""
    var image: Image = Image("profilepic")
    var reviews: [ReviewTest]? = []
    
    init(id: Int, username: String, image: Image, reviews: [ReviewTest]? = []) {
        self.id = id
        self.username = username
        self.image = image
        self.reviews = reviews!
    }
    
    init() {}
}



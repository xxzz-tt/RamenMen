//
//  ReviewTest.swift
//  RamenMen
//
//  Created by X ZZ on 23/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import Combine
import SwiftUI

class ReviewTest : ObservableObject, Identifiable {
    var id = 0
    @Published var dateOfConsumption = Date()
    @Published var dateOfReview = Date()
    @Published var timeOfReview : Int = 1000
//    @Published var user : UserTest = UserTest()
//    @Published var ramen : RamenTest = RamenTest()
    @Published var user : Int = 1
    @Published var ramen : Int = 2
    @Published var star : Int = 0
    @Published var value : Int = 0
    @Published var spiciness : Int = 0
    @Published var comments : String = ""
    
//    init(user: UserTest, ramen: RamenTest, star: Int, value: Int, spicy spiciness: Int, comments: String) {
//        self.user = user
//        self.ramen = ramen
//        self.star = star
//        self.value = value
//        self.spiciness = spiciness
//        self.comments = comments
//    }
    
    init(id: Int, user: Int, ramen: Int) {
        self.id = id
        self.user = user
        self.ramen = ramen
    }
    
    init(id: Int, user: Int, ramen: Int, star: Int, value: Int, spicy spiciness: Int, comments: String) {
        self.id = id
        self.user = user
        self.ramen = ramen
        self.star = star
        self.value = value
        self.spiciness = spiciness
        self.comments = comments
    }
    
    init() {}
}


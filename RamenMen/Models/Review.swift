//
//  Review.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

class Review: Identifiable, ObservableObject {
    var id: String = ""
    @Published var dateOfConsumption: Date = Date()
    @Published var dateOfReview: Date = Date()
    @Published var timeOfReview: Int = 1000
    @Published var userId: Int = 0
    @Published var ramenId: String = ""
    @Published var star: Int = 0
    @Published var value: Int = 0
    @Published var spiciness: Int = 0
    @Published var comments: String = ""
    
    init(id: String, userId: Int, ramenId: String) {
        self.id = id
        self.userId = userId
        self.ramenId = ramenId
    }
        
    init(id: String, userId: Int, ramenId: String, star: Int, value: Int, spicy spiciness: Int, comments: String) {
        self.id = id
        self.userId = userId
        self.ramenId = ramenId
        self.star = star
        self.value = value
        self.spiciness = spiciness
        self.comments = comments
    }
    
    init(id: String, dateOfConsumption: Date, dateOfReview: Date, timeOfReview: Int, userId: Int, ramenId: String, star: Int, value: Int, spiciness: Int, comments: String) {
        self.id = id
        self.dateOfConsumption = dateOfConsumption
        self.dateOfReview = dateOfReview
        self.timeOfReview = timeOfReview
        self.userId = userId
        self.ramenId = ramenId
        self.star = star
        self.value = value
        self.spiciness = spiciness
        self.comments = comments
    }
        
    init() {}
}


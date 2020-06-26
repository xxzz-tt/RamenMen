//
//  Review.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct Review: Identifiable, Codable {
    var id: String
    var dateOfConsumption: Date
    var dateOfReview: Date
    var timeOfReview: Int
    var userId: Int
    var ramenId: Int
    var star: Int
    var value: Int
    var spiciness: Int
    var comments: String
}


//
//  ReviewView.swift
//  RamenMen
//
//  Created by XuanZhi on 23/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

class ReviewViewModel<T>: ObservableObject {
    @Published var reviews = [Review]()
    @Published var holding = [T]()
    
    var db = Firestore.firestore()
    
    func getData() {
        db.collection("reviews").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let dateOfConsumption = i.document.get("date of consumption") as! String
                        let dateOfReview = i.document.get("date of review") as! String
                        let timeOfReview = i.document.get("time of review") as? Int ?? -1
                        let userId = i.document.get("user id") as? Int ?? -1
                        let ramenId = i.document.get("ramen id") as? Int ?? -1
                        let star = i.document.get("star") as? Int ?? -1
                        let value = i.document.get("value") as? Int ?? 0
                        let spiciness = i.document.get("spiciness") as? Int ?? 0
                        let comments = i.document.get("comments") as? String ?? ""
                        let id = i.document.documentID
                        
                        self.reviews.append(Review(id: id, dateOfConsumption: dateOfConsumption, dateOfReview: dateOfReview, timeOfReview: timeOfReview, userId: userId, ramenId: ramenId, star: star, value: value, spiciness: spiciness, comments: comments))
                    }
                }
            }
        }
    }
    
    func getCategory(_ catName: T){
        db.collection("reviews").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let name = i.document.get(catName) as! T

                        self.holding.append(name)
                    }
                }
            }
        }
    }
}

struct ReviewView: View {
    @ObservedObject var reviewModel = ReviewViewModel<Any>()
    
    init() {
        reviewModel.getData()
    }
    
    var body: some View {
//        Text("\(reviewModel.reviews.count)")
        List(reviewModel.reviews) { review in
            Text("\(review.star)")
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}

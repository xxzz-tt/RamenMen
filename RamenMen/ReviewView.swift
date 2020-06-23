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

class ReviewViewModel: ObservableObject {
    @Published var reviews = [Review]()
//    @Published var holding = [String]()
    
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
                        let dateOfConsumption = i.document.get("dateOfConsumption") as? String ?? "none"
                        let dateOfReview = i.document.get("dateOfReview") as? String ?? ""
                        let timeOfReview = i.document.get("timeOfReview") as? Int ?? -1
                        let userId = i.document.get("userId") as? Int ?? -1
                        let ramenId = i.document.get("ramenId") as? Int ?? -1
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
    
//    func getCategory(_ catName: String){
//        db.collection("ramen").addSnapshotListener {
//            (query, err) in
//            DispatchQueue.main.async {
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                } else {
//                    print("no errors")
//                    for i in query!.documentChanges {
//                        let name = i.document.get("name") as! String
//
//                        self.holding.append(name)
//                    }
//                }
//            }
//        }
//    }
    
}

struct ReviewView: View {
    @ObservedObject var reviewModel = ReviewViewModel()
    
    init() {
        reviewModel.getData()
    }
    
    var body: some View {
//        Text("\(reviewModel.reviews.count)")
        List(reviewModel.reviews) { review in
            Text(review.comments)
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}

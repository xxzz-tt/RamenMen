//
//  ReviewView.swift
//  RamenMen
//
//  Created by XuanZhi on 26/6/20.
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
                        
                        let dateOfConsumption = i.document.get("date of consumption") as? Timestamp ?? Timestamp()
                        let dateOfReview = i.document.get("date of review") as? Timestamp ?? Timestamp()
                        let timeOfReview = i.document.get("time of review") as? Int ?? -1
                        let userId = i.document.get("user id") as? Int ?? 0
                        let ramenId = i.document.get("ramen id") as? String ?? ""
                        let star = i.document.get("star") as? Int ?? -1
                        let value = i.document.get("value") as? Int ?? 0
                        let spiciness = i.document.get("spiciness") as? Int ?? 0
                        let comments = i.document.get("comments") as? String ?? ""
                        let id = i.document.documentID
                        
                        self.reviews.append(Review(id: id, dateOfConsumption: dateOfConsumption.dateValue(), dateOfReview: dateOfReview.dateValue(), timeOfReview: timeOfReview, userId: userId, ramenId: ramenId, star: star, value: value, spiciness: spiciness, comments: comments))
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
    
    public func addReview(_ newReview: Review) {
        let id = UUID.init().uuidString
        let docData: [String: Any] = [
            "date of consumption": newReview.dateOfConsumption,
            "date of review": newReview.dateOfReview,
            "time of review": newReview.timeOfReview,
            "user id": newReview.userId,
            "ramen id": newReview.ramenId,
            "star": newReview.star,
            "value": newReview.value,
            "spiciness": newReview.spiciness,
            "comments": newReview.comments
        ]
        // add to reviews collection
        db.collection("reviews").document(id).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        // update reviews array under ramen
        db.collection("ramen").document(newReview.ramenId).updateData([
            "reviews": FieldValue.arrayUnion([id])
        ])
    }
    
    func getUser(_ userId: Int) {
        
    }
}

struct ReviewView: View {
    @ObservedObject var reviewModel = ReviewViewModel<Any>()

    init() {
        reviewModel.getData()
    }
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
//        Text("\(reviewModel.reviews.count)")
        List(reviewModel.reviews) { review in
            Text("\(review.dateOfReview, formatter: self.dateFormatter)")
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}

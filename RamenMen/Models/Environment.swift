//
//  File.swift
//  RamenMen
//
//  Created by X ZZ on 29/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

class Environment: ObservableObject {
    @Published var userData: [User] = []
    @Published var ramenData: [Ramen] = []
    @Published var reviewData: [Review] = []
    @Published var user: User = User()
    @Published var nextId: Int = 10
    
    //database functions (has errors! comment out if needed)
//    var db = Firestore.firestore()
//
//    func getRamenData() {
//        db.collection("ramen").addSnapshotListener {
//            (query, err) in
//            DispatchQueue.main.async {
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                } else {
//                    print("no errors")
//                    for i in query!.documentChanges {
//                        let name = i.document.get("name") as? String ?? ""
//                        let style = i.document.get("style") as? String ?? ""
//                        let brand = i.document.get("brand") as? String ?? ""
//                        let image = i.document.get("image") as? String ?? ""
//                        let searchableName = i.document.get("searchable name") as? String ?? ""
//                        let star = i.document.get("average stars") as? Int ?? 0
//                        let spiciness = i.document.get("spiciness") as? Int ?? 0
//                        let reviews = i.document.get("reviews") as? [String] ?? []
//                        let id = i.document.documentID
//
//                        self.ramenData.append(Ramen(id: id, brand: brand, name: name, style: style, image: image, searchableName: searchableName, star: Float(star), spiciness: Float(spiciness), reviews: reviews))
//                    }
//                }
//            }
//        }
//    }
//    
//    func getUserData() {
//        db.collection("users").document("CfKgJyx5N3jt8kMkQFUd").addSnapshotListener {
//            (query, err) in
//            DispatchQueue.main.async {
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                } else {
//                    let id = query!.documentID
//                    let anUser = query!.data()
//
//                    self.user = User(id: id, username: anUser!["username"] as! String, password: anUser?["password"] as! String, image: anUser?["image"] as! String, reviews:anUser!["reviews"] as! [String])
//                }
//            }
//        }
//    }
//    
//    func getData() {
//        db.collection("reviews").addSnapshotListener {
//            (query, err) in
//            DispatchQueue.main.async {
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                } else {
//                    print("no errors")
//                    for i in query!.documentChanges {
//
//                        let dateOfConsumption = i.document.get("date of consumption") as? Timestamp ?? Timestamp()
//                        let dateOfReview = i.document.get("date of review") as? Timestamp ?? Timestamp()
//                        let timeOfReview = i.document.get("time of review") as? Int ?? -1
//                        let userId = i.document.get("user id") as? String ?? ""
//                        let ramenId = i.document.get("ramen id") as? String ?? ""
//                        let star = i.document.get("star") as? Int ?? -1
//                        let value = i.document.get("value") as? Int ?? 0
//                        let spiciness = i.document.get("spiciness") as? Int ?? 0
//                        let comments = i.document.get("comments") as? String ?? ""
//                        let id = i.document.documentID
//
//                        self.reviewData.append(Review(id: id, dateOfConsumption: dateOfConsumption.dateValue(), dateOfReview: dateOfReview.dateValue(), timeOfReview: timeOfReview, userId: userId, ramenId: ramenId, star: star, value: value, spiciness: spiciness, comments: comments))
//                    }
//                }
//            }
//        }
//    }
    
    //local functions
    func getUserReviews(user: User) -> [Review] {
        return reviewData.filter{
            (review: Review) -> Bool in
            return review.userId == user.id
        }
    }
    
    func getRamenReviews(ramen: Ramen) -> [Review] {
        return reviewData.filter{
            (review: Review) -> Bool in
            return review.ramenId == ramen.id
        }
    }
    
    func getRamen(id: String) -> Ramen {
        //to be modified
        return self.ramenData.first{
            (ramen: Ramen) -> Bool in
            return ramen.id == id
            }!
    }
    
    func getUser(id: String) -> User {
        //to be modified
        return self.userData.first{
            (user: User) -> Bool in
            return user.id == id
            }!
    }
    
    func addReview(review: Review) {
        self.reviewData.append(review)
        self.getUser(id: review.userId).addReview(review: review)
        self.getRamen(id: review.ramenId).addReview(review: review)
        self.nextId += 1
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    //test items
    private var profileImage = "profilepic"
    private var ramenImage = "ramen1"
    
    //9 reviews
    var review111 = Review(id: "1", dateOfconsumption: "28.06.19", dateOfReview: "28.06.19", timeOfReview: 1000, userId: "1", ramenId: "1", star: 3, value: 2, spiciness: 3, comments: "no comments")
    var review211 = Review(id: "2", dateOfconsumption: "28.06.19", dateOfReview: "28.06.19", timeOfReview: 1000, userId: "1", ramenId: "1", star: 4, value: 2, spiciness: 3, comments: "delicious")
    var review321 = Review(id: "3", dateOfconsumption: "28.06.19", dateOfReview: "28.06.19", timeOfReview: 1000, userId: "2", ramenId: "1", star: 4, value: 1, spiciness: 2, comments: "i wonder")
    var review412 = Review(id: "4", userId: "1", ramenId: "2", star: 3, value: 4, spicy: 3, comments: "no comments")
    var review512 = Review(id: "5", dateOfconsumption: "28.06.19", dateOfReview: "28.06.19", timeOfReview: 1000, userId: "1", ramenId: "2", star: 4, value: 4, spiciness: 3, comments: "no comments")
    var review623 = Review(id: "6", userId: "2", ramenId: "3", star: 4, value: 1, spicy: 2, comments: "no comments")
    var review733 = Review(id: "7", dateOfconsumption: "28.06.19", dateOfReview: "28.06.19", timeOfReview: 1000, userId: "3", ramenId: "3", star: 3, value: 2, spiciness: 3, comments: "no comments")
    var review834 = Review(id: "8", userId: "3", ramenId: "4", star: 4, value: 2, spicy: 3, comments: "no comments")
    var review925 = Review(id: "9", userId: "2", ramenId: "5", star: 4, value: 1, spicy: 2, comments: "no comments")
    
    //5 ramens
    var ramen1 = Ramen(id: "1", brand: "Mama", name: "Tom Yum Shrimp", style: "Packet", image: "ramen1", searchableName: "", star: (3+4+4)/3, spiciness: (3+3+2)/3, value: (2+2+1)/3, reviews: ["1","2","3"])
    var ramen2 = Ramen(id: "2", brand: "A1", name: "Abalone Instant Noodle", style: "Packet", image: "ramen1", searchableName: "", star: Float(3.5), spiciness: Float(3), value: Float(4), reviews: ["4","5"])
    var ramen3 = Ramen(id: "3", brand: "Samyang", name: "Spicy Fire Chicken Noodle", style: "Packet", image: "ramen1", searchableName: "", star: Float(3.4), spiciness: Float(2.5), value: Float(1.5), reviews: ["6","7"])
    var ramen4 = Ramen(id: "4", brand: "Nissin", name: "Tomyam Seafood", style: "Cup", image: "ramen1", searchableName: "", star: Float(4), spiciness: Float(2), value: Float(3), reviews: ["8"])
    var ramen5 = Ramen(id: "5", brand: "Nissin", name: "Chili Crab", style: "Bowl", image: "ramen1", searchableName: "", star: Float(4), spiciness: Float(1), value: Float(2), reviews: ["9"])
    var ramen6 = Ramen(id: "6", brand: "Nongshim", name: "Kimchi Noodle", style: "Bowl", image: "ramen1", searchableName: "", star: Float(0), spiciness: Float(0), value: Float(0), reviews: [])
    var ramen7 = Ramen(id: "7", brand: "Samyang", name: "2x Spicy Fire Chicken Noodle", style: "Bowl", image: "ramen1", searchableName: "", star: Float(0), spiciness: Float(0), value: Float(0), reviews: [])
    var ramen8 = Ramen(id: "8", brand: "Samyang", name: "Fire Chicken Noodle - Carbo", style: "Bowl", image: "ramen1", searchableName: "", star: Float(0), spiciness: Float(0), value: Float(0), reviews: [])
    var ramen9 = Ramen(id: "9", brand: "Samyang", name: "Fire Chicken Noodle - Cheese", style: "Bowl", image: "ramen1", searchableName: "", star: Float(0), spiciness: Float(0), value: Float(0), reviews: [])
    var ramen10 = Ramen(id: "9", brand: "Myojo", name: "Dry Mala Noodle", style: "Bowl", image: "ramen1", searchableName: "", star: Float(0), spiciness: Float(0), value: Float(0), reviews: [])
    
    //3 users
    var user1s = User(id: "1", username: "I wonder", password: "", image: "profilepic", reviews: ["1", "2", "4", "5"])
    var user2s = User(id: "2", username: "Mehehe", password: "", image: "profilepic", reviews: ["3", "6", "9"])
    var user3s = User(id: "3", username: "xiao meng", password: "", image: "profilepic", reviews: ["7", "8"])

    
    init() {
        self.userData = [user1s, user2s, user3s]
        self.ramenData = [ramen1, ramen2, ramen3, ramen4, ramen5]
        self.reviewData = [review111, review211, review321, review412, review512, review623, review733, review834, review925]
        self.user = user2s
    }
}

struct Environment_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

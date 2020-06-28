//
//  UserView.swift
//  RamenMen
//
//  Created by XuanZhi on 26/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

class UserViewModel: ObservableObject {
    @Published var user = User()
//    @Published var holding = [String]()
    
    var db = Firestore.firestore()
    
    func getData() {
        db.collection("users").document("CfKgJyx5N3jt8kMkQFUd").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    let id = query!.documentID
                    let anUser = query!.data()
                    
                    self.user = User(id: id, username: anUser!["username"] as! String, password: anUser?["password"] as! String, image: anUser?["image"] as! String, reviews:anUser!["reviews"] as! [String])
                }
            }
        }
    }
}

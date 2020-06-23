//
//  View.swift
//  RamenMen
//
//  Created by XuanZhi on 23/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class V: ObservableObject {
    var db = Firestore.firestore()
    
    private func getCollection() {
        // [START get_collection]
        db.collection("ramen").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        // [END get_collection]
    }
}
struct Wiew: View {
    @ObservedObject var ramen = V.init()
    var body: some View {
        Text("")
    }
}

struct Wiew_Previews: PreviewProvider {
    static var previews: some View {
        Wiew()
    }
}

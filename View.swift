//
//  View.swift
//  
//
//  Created by XuanZhi on 23/6/20.
//

import SwiftUI

class V: ObservableObject {
    
    var db = 
    db.collection("users").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
            }
        }
    }
}

struct View: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        View()
    }
}

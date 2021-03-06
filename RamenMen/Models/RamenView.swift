//
//  RamenView.swift
//  RamenMen
//
//  Created by XuanZhi on 22/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

class RamenViewModel: ObservableObject {
    @Published var ramens = [Ramen]()
    @Published var holding = [String]()
    @Published var ramenReviews = [Review]()
    
    var db = Firestore.firestore()
    
    func getData() {
        db.collection("ramen").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let name = i.document.get("name") as? String ?? ""
                        let style = i.document.get("style") as? String ?? ""
                        let brand = i.document.get("brand") as? String ?? ""
                        let image = i.document.get("image") as? String ?? ""
                        let searchableName = i.document.get("searchable name") as? String ?? ""
                        let star = i.document.get("average stars") as? Float ?? 0
                        let spiciness = i.document.get("spiciness") as? Float ?? 0
                        let reviews = i.document.get("reviews") as? [String] ?? []
                        let id = i.document.documentID
                        
                        self.ramens.append(Ramen(id: id, brand: brand, name: name, style: style, image: image, searchableName: searchableName, star: star, spiciness: spiciness, reviews: reviews))
                    }
                }
            }
        }
    }

}

struct RamenView: View {
    @ObservedObject var viewModel = RamenViewModel()
    
    init() {
        viewModel.getData()
    }
    
    var body: some View {
        VStack {
        Text("hello")
//        List(viewModel.ramens) { ramen in
//            Text(ramen.brand)
//            Text(ramen.reviews[0])
////            Text("\((self.authState.getAllRamenReviews(ramen: ramen)).count) items")
//            List(self.viewModel.getAllRamenReviews(ramen: ramen)) { review in
//                Text(review.comments)
//            }
//        }
        }
    }
}

struct RamenView_Previews: PreviewProvider {
    static var previews: some View {
        RamenView()
    }
}

//
//  RamenProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RamenProfile: View {
//    var ramen: Ramen
    @ObservedObject var ramen: RamenTest
    @State private var showReviewWindow = false
    @State var showRatingForm = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    func getUser(userId: Int) -> UserTest {
        //To be modified
        UserTest()
    }
    
    var body: some View {
        RamenProfileView(ramen: ramen, showRatingForm:
            self.$showRatingForm).sheet(isPresented: self.$showRatingForm) {
                RatingForm(review: ReviewTest(id: 0, user: 0, ramen: self.ramen.id), ramen: self.ramen, showRatingForm: self.$showRatingForm)
        }
    }
}

struct RamenProfile_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfile(ramen: ramen1)
    }
}

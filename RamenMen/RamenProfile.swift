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
    @EnvironmentObject var env: Environment
    @ObservedObject var ramen: Ramen
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
                RatingForm(review: Review(id: String(self.env.nextId), userId: self.env.user.id, ramenId: self.ramen.id), ramen: self.ramen, showRatingForm: self.$showRatingForm).environmentObject(self.env)
        }
    }
}

struct RamenProfile_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfile(ramen: ramen1).environmentObject(Environment())
    }
}

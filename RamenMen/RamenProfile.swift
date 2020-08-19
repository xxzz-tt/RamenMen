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
    @EnvironmentObject var authState: AuthenticationState
    @ObservedObject var ramen: Ramen
    @State private var showReviewWindow = false
    @State var showRatingForm = false
    @State var cameFromScanner = false
    @Binding var showRamenProfile: Bool
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    //TODO: change hardcode userID
    // TODO: add mechanism to prevent reviews made when user is not logged in 
    var body: some View {
        RamenProfileView(ramen: ramen, showRatingForm:
        self.$showRatingForm, cameFromScanner: self.cameFromScanner, showRamenProfile: self.$showRamenProfile).sheet(isPresented: self.$showRatingForm) {
                RatingForm(review: Review(id: "temp", userId: self.authState.loggedInUser?.uid ?? "IV9vtchAAcKykGmUXc93", ramenId: self.ramen.id), ramen: self.ramen, showRatingForm: self.$showRatingForm).environmentObject(self.authState)
        }
    }
}

struct RamenProfile_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfile(ramen: AuthenticationState.shared.ramens[6], cameFromScanner: true, showRamenProfile: .constant(true)).environmentObject(AuthenticationState.shared)
    }
}

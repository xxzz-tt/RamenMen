//
//  RamenProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ReviewWindow: View {
    @ObservedObject var review : ReviewTest
    var userImage : Image
    var userName : String
    
    var body: some View {
        VStack {
            userImage
                .resizable()
                .frame(width: 70, height: 70)
            Text(userName)
            VStack {
                HStack {
                   Text("Deliciousness").padding(.horizontal).frame(height: 30.0)
                    Spacer()
                   StarRating(rating: $review.star, tappable: false)
                       .padding(.trailing)
                }.padding(.horizontal).frame(width: 330)
                HStack {
                    Text("Value").padding(.horizontal).frame(height: 30.0)
                    Spacer()
                    StarRating(rating: $review.value, tappable: false)
                        .padding(.trailing)
                }.padding(.horizontal).frame(width: 330)
                HStack {
                    Text("Spiciness").padding(.horizontal).frame(height: 30.0)
                    Spacer()
                    StarRating(rating: $review.spiciness, tappable: false)
                        .padding(.trailing)
                }.padding(.horizontal).frame(width: 330)
                ScrollView {
                    Text(review.comments)
                }
            }
        }.frame(width: 320, height: 320).background(Color.white)
    }
}

struct RamenProfileView: View {
//    var ramen: Ramen
    @ObservedObject var ramen: RamenTest
    @State private var showReviewWindow = false
    
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
        NavigationView {
             VStack {
                VStack {
                    ramen.image.resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    
                    
                    HStack(spacing: 70.0) {
                        Text("Average stars:")
                            .font(.body)
                            .fontWeight(.semibold)
                        
    //                        Text(String(format: "%.2f", ramen.stars) + "/5")
                        Text(String(format: "%.2f", Float(ramen.stars/ramen.reviews.count)) + "/5")
    //                        StarRating(rating: $ramen.stars, tappable: false)
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("What others say")
                        .padding(.trailing, 120.0)
                    ScrollView() {
                        ForEach(ramen.reviews) { review in
                            HStack() {
                                VStack(alignment: .leading) {
                                    self.getUser(userId: review.user).image.resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)
                                    
                                    Text(self.getUser(userId: review.user).username)
                                }.padding(.trailing).frame(width: 100.0)
                                                            
                                VStack(alignment: .leading) {
                                    
                                    VStack(alignment: .leading) {
                                        StarRating(rating: .constant(review.star), tappable: false)
                                    Spacer()
                                    
                                        Text(review.comments)
                                        Spacer()
                                    }
                                    
                                    Text("\(review.dateOfReview, formatter: self.dateFormatter)")
                                }.padding([.trailing, .top, .bottom]).frame(width: 150)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text(ramen.brand + " " + ramen.name), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {},
                label: {Text("Close")}))
//                .overlay(overlay: ReviewWindow(review: review11, userImage: Image("profile pic"), userName: "mehehe"))
        }
    }
}

struct RamenProfile_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfileView(ramen: ramen1)
    }
}

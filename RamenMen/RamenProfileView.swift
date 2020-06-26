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
            Spacer()
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
                }.frame(height: 80.0)
            }
        }.frame(width: 320, height: 330).background(Color.white)
    }
}

struct RamenProfileView: View {
//    var ramen: Ramen
    @ObservedObject var ramen: RamenTest
    @State private var showReviewWindow = false
    @State var reviewWindow: AnyView = AnyView(EmptyView())
    @Binding var showRatingForm: Bool
    
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
    
    func getReviewWindow(review: ReviewTest, image: Image, username: String) -> AnyView {
        return AnyView(ReviewWindow(review: review, userImage: image, userName: username))
    }
        
    var body: some View {
        ZStack {
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
                                }.onTapGesture {
                                    self.showReviewWindow = true
                                    self.reviewWindow = self.getReviewWindow(review: review, image: self.getUser(userId: review.user).image, username: self.getUser(userId: review.user).username)
                                }
                            }
                        }
                    }
                    }.background(
                            Color.white
                                .onTapGesture {
                                    withAnimation{
                                        self.showReviewWindow.toggle()
                                    }
                            }
                    )
                    .navigationBarTitle(Text(ramen.brand + " " + ramen.name), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {self.showRatingForm.toggle()},
                        label: {Text("Add Review")}))
            }
            
            if(self.showReviewWindow) {
//                GeometryReader{_ in
//                    self.reviewWindow
//                }.background(
//                    Color.black.opacity(0.65)
//                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                            withAnimation{
//                                self.showReviewWindow.toggle()
//                            }
//                    }, alignment: .center
//
//                )
                self.reviewWindow
            }
        }
    }
}

struct RamenProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfileView(ramen: ramen1, showRatingForm: .constant(false))
    }
}

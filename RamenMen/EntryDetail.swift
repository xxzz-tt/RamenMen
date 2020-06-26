//
//  EntryDetail.swift
//  RamenMen
//
//  Created by X ZZ on 17/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct EntryDetail: View {
    @EnvironmentObject var user: UserTest
    @ObservedObject var ramen: RamenTest
    @ObservedObject var review: ReviewTest
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    var trailingButton : some View {
        Button(action: {}, label:{Text("Edit")})
    }
    
    var body: some View {
        VStack {
            HStack {
                NavigationView {
                        VStack(alignment: .center) {
                            VStack(alignment: .center, spacing: -5) {
                                ramen.image.resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                Text(ramen.brand + " " + ramen.name).bold()
                            }.padding()
                            Spacer().frame(height: 10)
                            HStack {
                                Text("Consumed on").padding(.horizontal).frame(height: 30.0)
                                Spacer()
                                Text(" \(review.dateOfConsumption, formatter: dateFormatter)").padding(.horizontal).frame(height: 30.0)
                            }.padding(.horizontal)
                            HStack {
                                Text("Deliciousness").padding(.horizontal).frame(height: 30.0)
                                Spacer()
                                StarRating(rating: $review.star)
                                    .padding(.trailing)
                            }.padding(.horizontal)
                            HStack {
                                Text("Value").padding(.horizontal).frame(height: 30.0)
                                Spacer()
                                StarRating(rating: $review.value)
                                    .padding(.trailing)
                            }.padding(.horizontal)
                            HStack {
                                Text("Spiciness").padding(.horizontal).frame(height: 30.0)
                                Spacer()
                                StarRating(rating: $review.spiciness)
                                    .padding(.trailing)
                            }.padding(.horizontal)
                            Text("Comments").bold().padding([.top])
                            ScrollView {
                                Text(review.comments)
                            }.frame(width: 310, height: 100)
                        }.navigationBarTitle(Text("Review on \(review.dateOfReview, formatter: dateFormatter)"), displayMode: .inline)
                            .navigationBarItems(trailing: review.user == user2.id
                                ? AnyView(self.trailingButton)
                                : AnyView(EmptyView()))
                }
            }
        }
    }
}

struct EntryDetail_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(ramen: ramen1, review: review31).environmentObject(user2)
    }
}

//
//  RatingForm.swift
//  RamenMen
//
//  Created by X ZZ on 11/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RatingForm: View {
    @ObservedObject var review : ReviewTest
    @ObservedObject var ramen : RamenTest
//    @Environment(\.presentationMode) var presentationMode

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    init(review: ReviewTest, ramen: RamenTest) {
        self.review = review
        self.ramen = ramen
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 226/255, green: 118/255, blue:69/255, alpha: 1)
    }
    
//    @State var consumedOn = Date()
//    @State var deliciousness = 0
//    @State var value = 0
//    @State var spiciness = 0
//    @State var comment: String = ""
    
    func submit() {
    }
    
    func close() {
//        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        VStack {
            HStack {
                NavigationView {
                        VStack(alignment: .center) {
                            ramen.image.resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            HStack {
                                Text("Consumed on").padding(.horizontal).frame(height: 30.0)
                                Spacer()
                                NavigationLink(destination:
                                    VStack {
                                        Text("Choose a date in the past")
                                        DatePicker("", selection: $review.dateOfConsumption, in: ...Date(), displayedComponents: .date)
                                    }
                                ) {
                                    Text(" \(review.dateOfConsumption, formatter: dateFormatter)").padding(.horizontal).frame(height: 30.0)
                                }
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
                            TextField("Leave a comment", text: $review.comments).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                            Button(action: submit, label: {Text("Submit")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                                }).frame(width: 100, height: 30)
                                .background(Color.orange)
                                    .border(Color.orange, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        }.navigationBarTitle(Text("Rate \(ramen.brand + " " + ramen.name)"), displayMode: .inline)
                        .navigationBarItems(trailing: Button(action: close,
                            label: {Text("Close")}))
                }
            }
            Spacer()
        }
    }
}

struct RatingForm_Previews: PreviewProvider {
    static var previews: some View {
        RatingForm(review: ReviewTest(id: 1, user: 1, ramen: 1, star: 1, value: 2, spicy: 3, comments: "no comments"), ramen: RamenTest())
    }
}

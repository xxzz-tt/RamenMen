//
//  RatingForm.swift
//  RamenMen
//
//  Created by X ZZ on 11/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RatingForm: View {
    @State var comment: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                    VStack(alignment: .center) {
                        Image("nissin").resizable()
                            .scaledToFit()
                        HStack {
                            Text("Deliciousness").padding(.horizontal).frame(height: 30.0)
                            Spacer()
                            StarRating(rating: .constant(4))
                                .padding(.trailing)
                        }.padding(.horizontal)
                        HStack {
                            Text("Value").padding(.horizontal).frame(height: 30.0)
                            Spacer()
                            StarRating(rating: .constant(4))
                                .padding(.trailing)
                        }.padding(.horizontal)
                        HStack {
                            Text("Spiciness").padding(.horizontal).frame(height: 30.0)
                            Spacer()
                            StarRating(rating: .constant(4))
                                .padding(.trailing)
                        }.padding(.horizontal)
                        TextField("Leave a comment", text: $comment).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        Button(action: {}, label: {Text("Submit")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            }).frame(width: 100, height: 30)
                            .background(Color.orange)
                                .border(Color.orange, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }.navigationBarTitle(Text("Rate Ramen"))
                    .navigationBarItems(trailing: Button(action: {},
                        label: {Text("Cancel")}))
            }
            Spacer()
        }
    }
}

struct RatingForm_Previews: PreviewProvider {
    static var previews: some View {
        RatingForm()
    }
}

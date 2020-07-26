//
//  UserProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 10/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
//    @Binding var text: String
    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState

    @State var selection = 0
    @Binding var notLoggedIn: Bool
    
    @State var reviews = [Review]()
    @State var ramen = Ramen()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    func getRamen(id: String) -> Ramen {
        //to be modified
        return env.ramenData.first{
            (ramen: Ramen) -> Bool in
            return ramen.id == id
            }!
    }

    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
//                    Button(action: {self.notLoggedIn.toggle()}) {
//                        Text("Logout").foregroundColor(Color.blue)
//                    }
                    Button(action: {self.authState.signout()}) {
                        Text("Logout").foregroundColor(Color.blue)
                    }
                }
                VStack {
                    ProfileImage(image: Image("profilepic")).padding(.horizontal)
                    Text(self.authState.user.username)
    //                VStack {
    //                    TextField("User id", text: $text)
    //                    Divider()
    //                    TextField("Info", text: $text)
    //                    Divider()
    //                    TextField("Something", text: $text)
    //                }
    //                .padding(.trailing)
                }
                Divider()
                HStack {
                    Button(action: {self.selection = 0}) {
                        VStack {
                            Image("first").foregroundColor(.orange).frame(width: 20, height: 20)
                        Text("Past Entries")
                            .font(.body).foregroundColor(.orange)
                            }
                    }
                    Spacer().frame(width: 70)
                    Button(action: {self.selection = 1}) {
                        VStack {
                            Image(systemName: "star.fill").foregroundColor(.red)
                                    .frame(width: 20, height: 20)
                            Text("Favourites")
                                .font(.body).foregroundColor(.red)
                                }
                    }
                }
                Divider()
                if self.selection == 1 {
                     ScrollView {
                        Text("No Item")
                     }.frame(height: 310)
                } else {
                    ScrollView {
                        ForEach(self.authState.myReviews) { review in
                            HStack() {
                                VStack(alignment: .leading) {
                                Image(self.ramen.image).resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)

                                    Text(self.ramen.brand).font(.system(size: 14))
                                    Text(self.ramen.name).font(.system(size: 14))
                                    Text(self.ramen.style).font(.system(size: 14))
                                }.onAppear{
                                    self.authState.getRamenUser(review: review) {
                                        result in
                                        self.ramen = result
                                    }
                                }.padding(.trailing).frame(width: 100.0)

                                VStack(alignment: .leading) {

                                    VStack(alignment: .leading) {
                                        Text("Review on \(review.dateOfReview, formatter: self.dateFormatter)").font(.system(size: 11))
                                        StarRating(rating: .constant(review.star), tappable: false)
                                        Text(review.comments)
                                        Spacer()
                                    }
                                }.padding([.trailing, .top, .bottom]).frame(width: 150)
                            }

                        }
                    }.frame(height: 310)
                }
            }
            .padding()
        }
        .padding(.top)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(notLoggedIn: .constant(false)).environmentObject(AuthenticationState.shared)
    }
}


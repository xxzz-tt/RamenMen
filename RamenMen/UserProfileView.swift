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
    @EnvironmentObject var user: UserTest
    @State var selection = 0
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    func getRamen(id: Int) -> RamenTest {
        //to be modified
        return RamenTest()
    }

    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                EditButton().frame(width: 350,height: 10, alignment: .trailing).padding(.trailing)
                VStack {
                    ProfileImage(image: Image("profilepic")).padding(.horizontal)
                    Text(user.username)
    //                VStack {
    //                    TextField("User id", text: $text)
    //                    Divider()
    //                    TextField("Info", text: $text)
    //                    Divider()
    //                    TextField("Something", text: $text)
    //                }
    //                .padding(.trailing)
                }
                Spacer()
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
                     }.frame(height: 365)
                } else {
                    ScrollView {
                        ForEach(user.reviews) { review in
                            HStack() {
                                VStack(alignment: .leading) {
                                    self.getRamen(id: review.ramen).image.resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)

                                    Text(self.getRamen(id: review.ramen).name)
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
                    }.frame(height: 365)
                }
    //            TabView(selection: $selection) {
    //                ScrollView {
    //                    ForEach(user.reviews) { review in
    //                        HStack() {
    //                            VStack(alignment: .leading) {
    //                                self.getRamen(id: review.ramen).image.resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)
    //
    //                                Text(self.getRamen(id: review.ramen).name)
    //                            }.padding(.trailing).frame(width: 100.0)
    //
    //                            VStack(alignment: .leading) {
    //
    //                                VStack(alignment: .leading) {
    //                                    StarRating(rating: .constant(review.star), tappable: false)
    //                                Spacer()
    //
    //                                    Text(review.comments)
    //                                    Spacer()
    //                                }
    //
    //                                Text("\(review.dateOfReview, formatter: self.dateFormatter)")
    //                            }.padding([.trailing, .top, .bottom]).frame(width: 150)
    //                        }
    //
    //                    }
    //                }.tabItem {
    //                    VStack {
    //                            Image("first").foregroundColor(.orange)
    //                    Text("Past Entries")
    //                        .font(.body).foregroundColor(.orange)
    //                        }
    //                }.tag(0)
    //
    //                ScrollView {
    //                    Text("No Item")
    //                }.tabItem {
    //                    VStack(alignment: .leading) {
    //                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
    //                            VStack {
    //                                Image("first").foregroundColor(.red)
    //                        Text("Wish List")
    //                            .font(.body).foregroundColor(.red)
    //                            }
    //                        }
    //                    }
    //                }.tag(1)
    //            }
    //            ScrollView {
    //            HStack {
    //
    ////                VStack(alignment: .leading) {
    ////                    Button(action: {}) {
    ////
    ////                    }
    ////                }
    //
    //                Spacer()
    //            }.padding(.horizontal)
    //                Divider()
    //                VStack(alignment: .leading) {
    //                    Text("Settings")
    //                        .font(.title)
    //                    Circle()
    //                }.padding()
    //        }
                
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(user2)
    }
}


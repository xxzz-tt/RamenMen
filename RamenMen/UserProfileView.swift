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
//    @Binding var notLoggedIn: Bool
    
//    @State var reviews = [Review]()
    @State var ramen = Ramen()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    var reviewt1 = TestReviews(id: "1", ramen: "chillicrab", date: "07 June, 2020", star: 4, comments: "noice")
    var reviewt2 = TestReviews(id: "2", ramen: "mala", date: "15 June, 2020", star: 5, comments: "noice")
    var reviewt3 = TestReviews(id: "3", ramen: "mala", date: "15 July, 2020", star: 3, comments: "no comments")
    var reviewt4 = TestReviews(id: "4", ramen: "chillicrab", date: "21 July, 2020", star: 4, comments: "ok")
    var reviewt5 = TestReviews(id: "5", ramen: "2xspicy", date: "27 July, 2020", star: 5, comments: "extremely spicy")
    var reviews: [TestReviews]
    init() {
        self.reviews = [reviewt1, reviewt2, reviewt3, reviewt4, reviewt5]
    }
    func getRamen(id: String) -> Ramen {
        //to be modified
        return env.ramenData.first{
            (ramen: Ramen) -> Bool in
            return ramen.id == id
            }!
    }

    var body: some View {
        ZStack {
            Color.orange
            .opacity(0.1)
            .edgesIgnoringSafeArea(.all)
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {self.authState.signout()}) {
                        Text("Logout").foregroundColor(Color.blue)
                    }
                }
                VStack {
                    ProfileImage(image: Image("profilepic")).padding(.horizontal)
                    Text(self.authState.user.username).bold().padding(.top)
                }
                Divider()
                HStack {
                    Button(action: {self.selection = 0}) {
                        VStack {
                            Image(systemName: "bookmark.fill").foregroundColor(.blue).opacity(0.8).font(.title).frame(width: 30, height: 30)
                            Text("Past Entries").bold()
                            .font(.body).foregroundColor(.blue).opacity(0.8)
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
                        ForEach(self.reviews) { review in
//                            print(review.ramen)
                            HStack() {
                                VStack(alignment: .leading) {
                                    Image(review.ramen).resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)

//                                    Text(self.ramen.brand).font(.system(size: 14))
//                                    Text(self.ramen.name).font(.system(size: 14))
//                                    Text(self.ramen.style).font(.system(size: 14))
                                }
                                VStack(alignment: .leading) {

                                    VStack(alignment: .leading) {
                                        Text("Review on " + review.dateOfConsumption).font(.system(size: 15))
                                        StarRating(rating: .constant(review.star), tappable: false)
                                        Text(review.comments)
                                        Spacer()
                                    }
                            }
                                }.padding([.trailing, .top, .bottom]).frame(width: 350)
                            
                        }
                    }.frame(height: 310)
                }
            }
            .padding()
        }
        .padding(.top)
    }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(AuthenticationState.shared)
    }
}

struct TestReviews: Hashable, Identifiable {
    var id: String = ""
     var dateOfConsumption: String = "27 July, 2020"
     var userId: String = "tester"
    var ramen: String = "2xspicy"
   var star: Int = 0
    var value: Int = 0
    var spiciness: Int = 0
    var comments: String = ""
    
    init(id: String, ramen: String, date: String, star: Int, comments: String) {
        self.id = id
//        self.userId = userId
        self.ramen = ramen
        self.dateOfConsumption = date
        self.comments = comments
        self.star = star
    }
}

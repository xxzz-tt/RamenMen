//
//  RamenProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ReviewWindow: View {
    @ObservedObject var review : Review
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
//    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState
    @ObservedObject var ramen: Ramen
    @State private var showReviewWindow = false
    @State var reviewWindow: AnyView = AnyView(EmptyView())
    @Binding var showRatingForm: Bool
    @State var cameFromScanner = false
    @Binding var showRamenProfile: Bool
    
    @State var reviews = [Review]()
    @State var user = RamenMen.User()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
//    func getUser(id: String) -> User {
//        //to be modified
//        return env.userData.first{
//            (user: User) -> Bool in
//            return user.id == id
//            }!
//    }
    
    func getReviewWindow(review: Review, image: Image, username: String) -> AnyView {
        return AnyView(ReviewWindow(review: review, userImage: image, userName: username))
    }
        
    var body: some View {
        ZStack {
//            NavigationView {
                 VStack {
                    HStack {
                        Button(action: {self.showRamenProfile.toggle()}) {
                            Image(systemName: "chevron.left").resizable().frame(width: 15, height: 20).foregroundColor(Color.blue)
                        }.padding([.leading])
                        Spacer()
                    }
                    VStack {
                        Image(ramen.image).resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        Text(ramen.brand + " " + ramen.name).bold()
                        Button(action: {self.showRatingForm.toggle()},
                        label: {Text("Add Review")})
                        Spacer()
                        HStack(spacing: 70.0) {
                            Text("Average stars:")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text(String(format: "%.2f", Float(3.5)) + "/5")
                            
//                                StarRating(rating: $ramen.star, tappable: false)
                        }.onAppear{
                            print(self.ramen.name)
                        }
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("What others say")
                            .padding(.leading, 40.0)
                        ScrollView() {
//                            ForEach(env.getRamenReviews(ramen: ramen)) { review in
                        if (!reviews.isEmpty) {
//                            Text("just testing")
                            ForEach(reviews) { review in
                                HStack() {
//                                    Text("anything")
                                    VStack(alignment: .leading) {

    //TODO: fix how user is passed in - suspect value is overwritten each time

                                    Image("profilepic").resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)
                                    Text("ra men")

                                    }.onAppear {
                                    self.authState.getReviewUser(review: review) { result in
                                        print("yoz")
                                        print(result.username)
                                        self.user = result
                                    }
                                    }.padding(.trailing).frame(width: 100.0)

                                    VStack(alignment: .leading) {

                                        VStack(alignment: .leading) {
                                            StarRating(rating: .constant(review.star), tappable: false)
                                        Spacer()

                                    Text(review.comments)
                                Text("")
                                Spacer()
                            }

                                Text("\(Date(), formatter: self.dateFormatter)")
                                    }.padding([.trailing, .top, .bottom]).frame(width: 150)
                        }.onTapGesture {
                            self.showReviewWindow = true
//                            self.reviewWindow = self.getReviewWindow(review: review, image: Image(self.user.image), username: self.getUser(id: review.userId).username)
//                                        self.getUser(userId: review.user).username)
                                }
                            }
                            }
                            }
                        }.onAppear {
                        self.authState.getAllRamenReviews(ramen: self.ramen) { result in
                            print(result)
                            self.reviews = result
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
//                    .navigationBarTitle(Text(ramen.brand + " " + ramen.name), displayMode: .inline)
//                    .navigationBarItems(trailing: Button(action: {self.showRatingForm.toggle()},
//                        label: {Text("Add Review")}))
//            }
            
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
        RamenProfileView(ramen: AuthenticationState.shared.ramens[6], showRatingForm: .constant(false), cameFromScanner: true, showRamenProfile: .constant(true)).environmentObject(AuthenticationState.shared)
    }
}

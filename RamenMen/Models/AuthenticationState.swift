//
//  AuthenticationState.swift
//  RamenMen
//
//  Created by Xuan Zhi on 22/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import Foundation
import FirebaseFirestore
import Combine

enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationState: NSObject, ObservableObject {
    
    @Published var ramens = [Ramen]()
    @Published var ramenReviews = [Review]()
    
    var db = Firestore.firestore()
    
    // get ramen data
    func getRamenData() {
        db.collection("ramen").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let name = i.document.get("name") as? String ?? ""
                        let style = i.document.get("style") as? String ?? ""
                        let brand = i.document.get("brand") as? String ?? ""
                        let image = i.document.get("image") as? String ?? ""
                        let searchableName = i.document.get("searchable name") as? String ?? ""
                        let star = i.document.get("average stars") as? Float ?? 0
                        let spiciness = i.document.get("spiciness") as? Float ?? 0
                        let reviews = i.document.get("reviews") as? [String] ?? []
                        let id = i.document.documentID
                        
                        self.ramens.append(Ramen(id: id, brand: brand, name: name, style: style, image: image, searchableName: searchableName, star: star, spiciness: spiciness, reviews: reviews))
                    }
                }
            }
        }
    }
    
    func getAllRamenReviews(ramen: Ramen, completion: @escaping([Review]) ->()) {
        let reviewID = ramen.reviews
        var reviews: [Review] = [Review]()
        let group = DispatchGroup()
        for i in reviewID {
            group.enter()
            db.collection("reviews").document(i).getDocument {
                (query, err) in
//                DispatchQueue.main.async {
                print("hello", i)
                    if err != nil {
                        print("hello")
                    } else {
                        let dateOfConsumption = query!.get("date of consumption") as? Timestamp ?? Timestamp()
                        let dateOfReview = query!.get("date of review") as? Timestamp ?? Timestamp()
                        let timeOfReview = query!.get("time of review") as? Int ?? -1
                        let userId = query!.get("user id") as? String ?? ""
                        let ramenId = query!.get("ramen id") as? String ?? ""
                        let star = query!.get("star") as? Int ?? -1
                        let value = query!.get("value") as? Int ?? 0
                        let spiciness = query!.get("spiciness") as? Int ?? 0
                        let comments = query!.get("comments") as? String ?? "where"
                        reviews.append(Review(id: i, dateOfConsumption: dateOfConsumption.dateValue(), dateOfReview: dateOfReview.dateValue(), timeOfReview: timeOfReview, userId: userId, ramenId: ramenId, star: star, value: value, spiciness: spiciness, comments: comments))
                        print("yohshs")
                        print(comments)
                    }
//                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print(reviews)
            completion(reviews)
        }
    }
    
    func getReviewUser(review: Review, completion: @escaping(RamenMen.User) ->()) {
        let id = review.userId
        var user: RamenMen.User = User()
        let group = DispatchGroup()
        group.enter()
        db.collection("users").document(id).getDocument {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print("hello")
                } else {

                    let username = query!.get("username") as? String ?? ""
                    let password = query!.get("password") as? String ?? ""
                    let image = query!.get("image") as? String ?? ""
                    let reviews = query!.get("reviews") as? [String] ?? []
                    user = User(id: id, username: username, password: password, image: image, reviews: reviews)
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(user)
        }
    }
    
    func addAReview(review: Review) {
        let id = UUID.init().uuidString
        let docData: [String: Any] = [
            "date of consumption": review.dateOfConsumption,
            "date of review": review.dateOfReview,
            "time of review": review.timeOfReview,
            "user id": review.userId,
            "ramen id": review.ramenId,
            "star": review.star,
            "value": review.value,
            "spiciness": review.spiciness,
            "comments": review.comments
        ]
        // add to reviews collection
        db.collection("reviews").document(id).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        // update reviews array under ramen
        
//        db.collection("ramen").document(review.ramenId).updateData([
//            "reviews": FieldValue.arrayUnion(["id"])
//        ])

        // update user
        let temp = db.collection("users").document("IV9vtchAAcKykGmUXc93")
        temp.updateData([
            "reviews": FieldValue.arrayUnion([id])
        ])
    }
    
    @Published var loggedInUser: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: NSError?

    static let shared = AuthenticationState()

    private let auth = Auth.auth()
    fileprivate var currentNonce: String?
    
    override private init() {
        loggedInUser = auth.currentUser
        super.init()
        
        self.getRamenData()
        
//        self.getAllRamenReviews(ramen: ramen1) { result in
//            print("show result if any")
//            print(result)
//        }
        auth.addStateDidChangeListener(authStateChanged)
    }
    private func authStateChanged(with auth: Auth, user: FirebaseAuth.User?) {
        guard user != self.loggedInUser else { return }
        self.loggedInUser = user
    }

    func login(with loginOption: LoginOption) {
        self.isAuthenticating = true
        self.error = nil

        switch loginOption {
            case .signInWithApple:
                handleSignInWithApple()

            case let .emailAndPassword(email, password):
                handleSignInWith(email: email, password: password)
        }
    }

    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }

    func signup(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation does not match"])
            return
        }

        self.isAuthenticating = true
        self.error = nil

        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
        self.isAuthenticating = false
            if let user = auth?.user {
                self.loggedInUser = user
            } else if let error = error {
                self.error = error as NSError
            }
        }
    }
    
    func signout() {
        try? auth.signOut()
    }
    
    private func handleSignInWithApple() {
        // TODO
    }
}

struct AuthView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State var reviews = [Review]()
    @State var user = RamenMen.User()
 
    var body: some View {
        VStack {
        Text("hello")
            Text("\(reviews.count) items")
        List(reviews) { review in
            Text("hello how r u just testing")
            Text(review.comments)
            Text(self.user.image).onAppear {
            self.authState.getReviewUser(review: review) { result in
                self.user = result
            }
            }
            }
        }.onAppear {
            self.authState.getAllRamenReviews(ramen: self.authState.ramens[0]) { result in
                print(result[0].comments)
            self.reviews = result
        }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(AuthenticationState.shared)
    }
}

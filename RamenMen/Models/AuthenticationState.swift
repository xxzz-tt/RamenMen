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
import FirebaseFirestoreSwift

enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationState: NSObject, ObservableObject {
    
    @Published var ramens = [Ramen]()
    @Published var ramenReviews = [Review]()
    @Published var user = RamenMen.User()
    @Published var myReviews = [Review]()
    @Published var searchNames = [String]()
    @Published var bestRamens = [Ramen]()
    @Published var spicyRamens = [Ramen]()
    
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
    
    // get best ramen data
    func getBestRamen() {
        db.collection("bestRamen").addSnapshotListener {
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
                        
                        self.bestRamens.append(Ramen(id: id, brand: brand, name: name, style: style, image: image, searchableName: searchableName, star: star, spiciness: spiciness, reviews: reviews))
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
    
    func getRamenUser(review: Review, completion: @escaping(Ramen) ->()) {
        let id = review.ramenId
        var ramen: Ramen = Ramen()
        let group = DispatchGroup()
        group.enter()
        db.collection("users").document(id).getDocument {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print("hello")
                } else {

                    let name = query!.get("name") as? String ?? ""
                    let style = query!.get("style") as? String ?? ""
                    let brand = query!.get("brand") as? String ?? ""
                    let image = query!.get("image") as? String ?? ""
                    let searchableName = query!.get("searchable name") as? String ?? ""
                    let star = query!.get("average stars") as? Float ?? 0
                    let spiciness = query!.get("spiciness") as? Float ?? 0
                    let reviews = query!.get("reviews") as? [String] ?? []
                    ramen = Ramen(id: id, brand: brand, name: name, style: style, image: image, searchableName: searchableName, star: star, spiciness: spiciness, reviews: reviews)
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(ramen)
        }
    }
    
    func getCategory() {
        db.collection("ramen").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let name = i.document.get("searchable name") as! String
        
                        self.searchNames.append(name)
                    }
                }
            }
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
        
        db.collection("ramen").document(review.ramenId).updateData([
            AnyHashable("reviews"): FieldValue.arrayUnion([id])
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        if (!db.collection("bestRamen").document(review.ramenId).path.isEmpty) {
            db.collection("bestRamen").document(review.ramenId).updateData([
                AnyHashable("reviews"): FieldValue.arrayUnion([id])
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }

        // update user
        db.collection("users").document(review.userId).updateData([
            AnyHashable("reviews"): FieldValue.arrayUnion([id])
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    func getRamenByName(id: String) -> Ramen {
        //to be modified
//        return self.ramens.first{
//            (ramen: Ramen) -> Bool in
//            return ramen.searchableName == id
//            }!
        return Ramen(id: "1", brand: "Prima Taste", name: "Chili Crab Noodle", style: "Bowl", image: "chillicrab", searchableName: "Prima Taste Chili Crab Noodle", star: Float(4.0), spiciness: Float(2), value: Float(2), reviews: [])
    }
    
    @Published var loggedInUser: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    
    @Published var profile: UserProfile?
    private var profileRepository = UserProfileRepository()

    static let shared = AuthenticationState()

    private let auth = Auth.auth()
    fileprivate var currentNonce: String?
    
    override private init() {
        loggedInUser = auth.currentUser
        
        super.init()
        
        self.getRamenData()
        self.getCategory()
        self.getBestRamen()
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
                handleSignInWith(email: email, password: password) { (result, error) in
            }
        }
    }

    private func handleSignInWith(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
//        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
        auth.signIn(withEmail: email, password: password) { (result, error) in
          if let error = error {
            print("Error signing in: \(error)")
            completion(nil, error)
            return
          }

          guard let user = result?.user else { return }
          print("User \(user.uid) signed in.")
            self.isAuthenticating = false
            if let user = result?.user {
                self.loggedInUser = user
            } else if let error = error {
                self.error = error as NSError
            }

          self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
            print(user.uid)
            if let error = error {
              print("Error while fetching the user profile: \(error)")
              completion(nil, error)
              return
            }

            print(profile?.username ?? "erm hi")
            self.profile = profile
            completion(profile, nil)
            print(self.profile?.username ?? "nope")
          }
        }
        
    }

    func signup(email: String, password: String, username: String, passwordConfirmation: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation does not match!"])
            return
        }

        self.isAuthenticating = true
        self.error = nil

//        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing up: \(error)")
                completion(nil, error)
                return
            }
            guard let user = result?.user else { return }
            print("User \(user.uid) signed up.")
            print(self.isAuthenticating)
            print((self.loggedInUser?.email ?? "nope"))

            let userProfile = UserProfile(id: user.uid, username: username, password: password, image: "profilepic", reviews: [])
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                self.profile = profile
                completion(profile, nil)
            }
        }
        self.isAuthenticating = false
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
        self.profile = nil
    }
    
    private func handleSignInWithApple() {
        // TODO
    }
}

struct UserProfile: Codable {
    var id: String
    var username: String
    var password: String
    var image: String
    var reviews: [String]
}

class UserProfileRepository: ObservableObject {
  private var db = Firestore.firestore()

  func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    do {
      try
    db.collection("users").document(profile.id).setData(from: profile)
      completion(profile, nil)
    }
    catch let error {
      print("Error writing city to Firestore: \(error)")
      completion(nil, error)
    }
  }

  func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    db.collection("users").document(userId).getDocument { (snapshot, error) in
        let profile = try? snapshot?.data(as: UserProfile.self)
        print(profile?.username ?? "test fetch")
      completion(profile, error)
    }
  }
}

struct AuthView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State var reviews = [Review]()
    @State var user = RamenMen.User()
 
    var body: some View {
        VStack {
        Text("hello")
            Text("\(self.authState.ramens.count) items")
            List(self.authState.ramens) { ramen in
            Text("hello how r u just testing")
            Text(ramen.style)
            }
        }
//        .onAppear {
//            self.authState.getAllRamenReviews(ramen: self.authState.ramens[0]) { result in
//                print(result[0].comments)
//            self.reviews = result
//        }
//        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(AuthenticationState.shared)
    }
}

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
    @Published var holding = [String]()
    
    var db = Firestore.firestore()
    
    func getData() {
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
    
    func getCategory<T>(_ catName: T){
        
        db.collection("ramen").addSnapshotListener {
            (query, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                } else {
                    print("no errors")
                    for i in query!.documentChanges {
                        let name = i.document.get(catName) as? String ?? ""
                        
                        self.holding.append(name)
                    }
                }
            }
        }
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

//
//  FakeLogin.swift
//  RamenMen
//
//  Created by X ZZ on 29/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
//    @EnvironmentObject var env: Environment
//    @State var email: String = ""
//    @State var password: String = ""
//    @Binding var notLoggedIn: Bool
//    @State var alert: Bool = false

    @EnvironmentObject var authState: AuthenticationState
    @State var authType = AuthenticationType.login
    
    var body: some View {
        
        VStack {
            if (!authState.isAuthenticating) {
                LoginForm(authType: $authType)
            } else {
//                ProgressView()
            }

//            SignInAppleButton {
//                self.authState.login(with: .signInWithApple)
//            }
//            .frame(width: 130, height: 44)
        }.offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
//        LoginPage(notLoggedIn: .constant(true)).environmentObject(Environment())
        LoginPage()
    }
}

//    func findUser(username: String) {
//        let temp = env.userData.first { (user: User) -> Bool in
//            return user.username == username
//        }
//        if (temp != nil) {
//            env.setUser(user: temp!)
//            self.notLoggedIn.toggle()
//            return
//        }
//        self.alert = true
//    }
    
//    var body: some View {
//            ZStack {
//                Color.init(red: (78/255), green: (76/255), blue: (74/255)).edgesIgnoringSafeArea(.all)
//                VStack {
//                    Image("appicon")
//                    Text("The Login Page").font(.custom("sniglet", size: 24)).foregroundColor(.white)
//                    TextField("Email address", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 200, height: 40, alignment: .center)
//                    SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 200, height: 40, alignment: .center)
//                    Spacer().frame(height: 10)
//                    NavigationLink(destination: ContentView().environmentObject(env).navigationBarBackButtonHidden(true)
//                        .navigationBarHidden(true)) {
//                       Text("Login")
//                    }
//                    Button(action: {self.findUser(username: self.username)}, label: {Text("Login")
//                    .font(.subheadline)
//                    .foregroundColor(Color.white)
//                    }).frame(width: 100, height: 30)
//                    .background(Color.orange)
//                        .cornerRadius(10)
//                    .alert(isPresented: $alert) {
//                        Alert(title: Text("User not found"), message: Text(""), dismissButton: .default(Text("Try Again")))
//                    }
//                }
//            }
//        .navigationBarHidden(true)
//        }

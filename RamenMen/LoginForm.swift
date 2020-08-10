//
//  LoginForm.swift
//  RamenMen
//
//  Created by Xuan Zhi on 22/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct LoginForm: View {
    @EnvironmentObject var authState: AuthenticationState

    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""
    @State var username: String = ""
    @State var isShowingPassword = false

    @Binding var authType: AuthenticationType
    
    private func emailAuthenticationTapped() {
        switch authType {
        case .login:
            authState.login(with: .emailAndPassword(email: email, password: password))

        case .signup:
            authState.signup(email: email, password: password, passwordConfirmation: passwordConf)
        }
    }

    private func footerButtonTapped() {
        clearFormField()
        authType = authType == .signup ? .login : .signup
    }

    private func clearFormField() {
        email = ""
        password = ""
        passwordConf = ""
        isShowingPassword = false
    }
    
    var body: some View {
        ZStack {
        Color.init(red: (78/255), green: (76/255), blue: (74/255)).edgesIgnoringSafeArea(.all)
        VStack {
            Image("appicon")
            Text("The Login Page").font(.custom("sniglet", size: 24)).foregroundColor(.white)
            TextField("Email address", text: $email).textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocapitalization(.none).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 288, height: 40, alignment: .center)
            
            if authType == .signup {
                TextField("Username", text: $username).autocapitalization(.none).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 288, height: 40, alignment: .center)
            }
            
            if isShowingPassword {
                TextField("Password", text: $password)
                .textContentType(.password)
                .autocapitalization(.none)
            } else {
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 288, height: 40, alignment: .center)
                Spacer().frame(height: 10)
            }
            if authType == .signup {
                if isShowingPassword {
                    TextField("Password Confirmation", text: $passwordConf)
                        .textContentType(.password).autocapitalization(.none)
                } else {
                    SecureField("Password Confirmation", text: $passwordConf)
                }
            }

            Toggle("Show password", isOn: $isShowingPassword)
                .foregroundColor(.white).frame(width: 200, height: 40, alignment: .center)
            Button(action: emailAuthenticationTapped) {
                Text(authType.text)
                .font(.callout)
            }
            .buttonStyle(XCAButtonStyle())
            .disabled(email.count == 0 && password.count == 0).padding()
            
            Button(action: footerButtonTapped) {
                Text(authType.footerText)
                .font(.callout)
            }
            .foregroundColor(.white)
            }.textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 288).alert(item: $authState.error) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription))
            }
        }
    }
}

struct XCAButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 44)
            .foregroundColor(Color.white)
            .background(Color.init(red: (245/255), green: (106/255), blue: (93/255)))
            .cornerRadius(8)
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(authType: .constant(.signup)).environmentObject(AuthenticationState.shared)
    }
}

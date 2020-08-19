//
//  ContentView.swift
//  RamenMen
//
//  Created by XuanZhi on 5/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var env: Environment
    @State private var selection = 0
    @State var notLoggedIn = false
    @State var showRamenProfile = false
    @State var ramen: Ramen?

    @EnvironmentObject var authState: AuthenticationState
 
    var body: some View {
        Group {
          if (authState.loggedInUser != nil) {
            ZStack {
                HomeTab(showRamenProfile: self.$showRamenProfile, ramen: self.$ramen).environmentObject(authState)
                
                if (self.showRamenProfile && self.ramen != nil) {
                    RamenProfile(ramen: self.ramen!, showRamenProfile: self.$showRamenProfile).environmentObject(authState)
                }
            }
          } else {
            LoginPage(authType: .login)
          }
        }.animation(.easeInOut)
        .transition(.move(edge: .bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().environmentObject(Environment())
        ContentView().environmentObject(AuthenticationState.shared)
    }
}

class AnyGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touchedView = touches.first?.view, touchedView is UIControl {
            state = .cancelled

        } else if let touchedView = touches.first?.view as? UITextView, touchedView.isEditable {
            state = .cancelled

        } else {
            state = .began
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}
//
//ZStack {
//            TabView(selection: $selection){
//                Text("first view")
//                .tabItem {
//                    VStack {
//                        Image("first")
//                        Text("Health tracker")
//                    }
//                }
//                .tag(1)
//
//                SearchBar().environmentObject(env)
//                    .padding([.top], 10).padding(0.0)
//                    .tabItem {
//                        VStack {
//                            Text("Home")
//                            Image(systemName: "plus.circle.fill").font(.largeTitle).foregroundColor(.green)
//                        }
//                    }
//                    .tag(0)
//
//
//                UserProfileView(notLoggedIn: $notLoggedIn).environmentObject(env).tabItem {
//                    VStack {
//                        Image("first")
//                        Text("My Account")
//                    }
//                }.tag(2)
//            }
//
////            if(notLoggedIn) {
////                LoginPage(notLoggedIn: $notLoggedIn).environmentObject(self.env)
////            }
//        }

//
//  HomeTab.swift
//  RamenMen
//
//  Created by Xuan Zhi on 23/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var selection = 0
    var body: some View {
        VStack {
        ZStack {
            TabView(selection: $selection){
                Text("first view")
                .tabItem {
                VStack {
                    Image("first")
                    Text("Health tracker")
                }
            }.tag(1)
        
                Text("home view")
                    .tabItem {
                    VStack {
                        Image("first")
                        Text("Home")
                    }
                }.tag(0)
//            SearchBar().environmentObject(env)
//                .padding([.top], 10).padding(0.0)
//                .tabItem {
//                    VStack {
//                        Text("Home")
//                        Image(systemName: "plus.circle.fill").font(.largeTitle).foregroundColor(.green)
//                    }
//                }.tag(0)
        
        
//            UserProfileView(notLoggedIn: $notLoggedIn).environmentObject(env).tabItem {
//                    VStack {
//                        Image("first")
//                            Text("My Account")
//                    }
//                }.tag(2)
                    }
            }
        }
        
    }
    private func signoutTapped() {
        authState.signout()
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}

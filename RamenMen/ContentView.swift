//
//  ContentView.swift
//  RamenMen
//
//  Created by XuanZhi on 5/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var env: Environment
    @State private var selection = 0
    @State var notLoggedIn = true
 
    var body: some View {
<<<<<<< HEAD
        TabView(selection: $selection){
            Text("first view")
            .tabItem {
                VStack {
                    Image("first")
                    Text("Health tracker")
                }
            }
            .tag(1)

            SearchBar().environmentObject(user).padding(10).padding(.leading, 5)
=======
//        Group {
//            if(self.notLoggedIn) {
//                FakeLogin(notLoggedIn: $notLoggedIn).environmentObject(env)
//            } else {
//
//            }
//        }
        ZStack {
            TabView(selection: $selection){
                Text("first view")
>>>>>>> Added database functions
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Health tracker")
                    }
                }
                .tag(1)
                
                SearchBar().environmentObject(env)
                    .padding([.top], 10).padding(0.0)
                    .tabItem {
                        VStack {
                            Text("Home")
                            Image(systemName: "plus.circle.fill").font(.largeTitle).foregroundColor(.green)
                        }
                    }
                    .tag(0)


<<<<<<< HEAD
            Text("firstview").tabItem {
                VStack {
                    Image("first")
                    Text("My Account")
                }
            }.tag(2)
=======
                UserProfileView(notLoggedIn: $notLoggedIn).environmentObject(env).tabItem {
                    VStack {
                        Image("first")
                        Text("My Account")
                    }
                }.tag(2)
            }
            
            if(notLoggedIn) {
                LoginPage(notLoggedIn: $notLoggedIn).environmentObject(self.env)
            }
>>>>>>> Added database functions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Environment())
    }
}

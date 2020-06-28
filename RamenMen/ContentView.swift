//
//  ContentView.swift
//  RamenMen
//
//  Created by XuanZhi on 5/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserTest
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("first view")
            .tabItem {
                VStack {
                    Image("first")
                    Text("Health tracker")
                }
            }
            .tag(1)
            
            SearchBar().padding(10).padding(.leading, 5)
                .tabItem {
                    VStack {
                        Text("Home")
                        Image(systemName: "plus.circle.fill").font(.largeTitle).foregroundColor(.green)
                    }
                }
                .tag(0)


            UserProfileView().environmentObject(user).tabItem {
                VStack {
                    Image("first")
                    Text("My Account")
                }
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(user2)
    }
}

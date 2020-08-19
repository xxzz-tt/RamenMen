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
    @Binding var showRamenProfile: Bool
    @Binding var ramen: Ramen?
    var body: some View {
        VStack {
        ZStack {
            TabView(selection: $selection){
                Tracker().environmentObject(authState)
                .tabItem {
                VStack {
                    Image(systemName: "waveform.path.ecg").font(.title)
                    Text("Health tracker")
                }
            }.tag(1)
        
            SearchBar(showRamenProfile: self.$showRamenProfile, ramenn: self.$ramen).environmentObject(authState)
                .padding([.top], 10).padding(0.0)
                .tabItem {
                    VStack {
                        Text("Home")
                        Image(systemName: "house.fill").font(.title).foregroundColor(.green)
                    }
                }.tag(0)
        
        
                UserProfileView().environmentObject(authState).tabItem {
                    VStack {
                        Image(systemName: "person.fill").font(.title)
                        Text("My Account")
                    }
                }.tag(2)
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
        HomeTab(showRamenProfile: .constant(false), ramen: .constant(Ramen())).environmentObject(AuthenticationState.shared)
    }
}

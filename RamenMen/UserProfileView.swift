//
//  UserProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 10/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    @Binding var text: String

    var body: some View {
        
        VStack {
            
            EditButton().frame(width: 350,height: 10, alignment: .trailing).padding(.trailing)
            HStack {
                ProfileImage(image: Image("profilepic")).padding(.horizontal)
                
                VStack {
                    TextField("User id", text: $text)
                    Divider()
                    TextField("Info", text: $text)
                    Divider()
                    TextField("Something", text: $text)
                }
                .padding(.trailing)
            }
            
            Divider().padding([.leading, .bottom, .trailing])
            Spacer()
            ScrollView {
            HStack {
                
                VStack(alignment: .leading) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        VStack {
                            Image("first").foregroundColor(.orange)
                    Text("Past Entries")
                        .font(.body).foregroundColor(.orange)
                        }
                    }
                }
                
                Spacer()
                VStack(alignment: .leading) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        VStack {
                            Image("first").foregroundColor(.red)
                    Text("Wish List")
                        .font(.body).foregroundColor(.red)
                        }
                    }
                }
            }.padding(.horizontal)
                Divider()
                VStack(alignment: .leading) {
                    Text("Settings")
                        .font(.title)
                    Circle()
                }.padding()
        }
            
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(text: .constant(""))
    }
}


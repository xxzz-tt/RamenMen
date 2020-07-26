//
//  SearchBar.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

struct SearchBar: View {
    @State private var searchText = ""
    @State private var cancel: Bool = false
    @State private var isEditing = false
    @State private var shouldReturn = false
    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Start your search!", text: $searchText, onEditingChanged: { edit in
                        self.cancel = true
                    }, onCommit: {
                        print("onCommit")
                        }).background(Color(.systemGray6)).onTapGesture {
                        self.isEditing = true
                        }
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                            Image(systemName: "multiply.circle.fill").foregroundColor(.gray).padding(.horizontal, 8)
                        }
                    }
                }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                        .cornerRadius(15.0)
                if cancel  {
                    Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.searchText = ""
                    self.cancel = false
                    self.isEditing = false
                }.padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }.frame(width: 340, height: 60, alignment: .center)
                
                if isEditing {
//                    NavigationView {
//                    Text("Search Result")
                    List(self.authState.ramens) { ramen in
                        NavigationLink(destination: RamenProfile(ramen: ramen).environmentObject(self.authState)) {
//                            RamenRow(ramen: ramen)
                        Text(ramen.name)
//                        ForEach(self.authState.searchNames.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
//                            searchText in Text(searchText)
//                        }
                        }
                        }
//                    }
//                    .navigationBarTitle("Search Results")
//                    .navigationBarTitle("Back").navigationBarHidden(false)
                } else {
                    VStack(alignment: .leading) {
//                        NavigationView {
                        ForEach(authState.ramens) { ramen in
                            NavigationLink(destination: RamenProfile(ramen: ramen).environmentObject(self.authState)) {
                            HStack {
                                Text(ramen.name) .frame(width: 200.0, height: 10.0).padding(.trailing, 16.0)
                                StarRating(rating: .constant(Int(ramen.star))).padding(.trailing)
                            }.padding(.bottom)
                            }
                            }
//                        }.navigationBarTitle("Reviews of the week")
                        Spacer()
                        Text("Recommended for You").bold()
                        ScrollView {
                            HStack {
                            VStack {
                            RamenIcon(image: Image("nissin"))
                            Text("Nissin TY")
                            }.padding([.bottom, .trailing])

                        VStack {
                        RamenIcon(image: Image("ramen1"))
                        Text("Doggiemen")
                        }.padding([.bottom, .trailing])

                        VStack {
                        RamenIcon(image: Image("ramen1"))
                        Text("Dogmen x2")
                        }.padding([.bottom, .trailing])
                        }.padding()
                        }
//                        PopularityChart()
                    }
                }
                }
            .navigationBarTitle("Back").navigationBarHidden(true)
                .padding(.horizontal)
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar().environmentObject(AuthenticationState.shared)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}


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
    @Binding var showRamenProfile: Bool
    @Binding var ramenn: Ramen?
//    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState
    @State var ramen: Ramen?
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ScanButton(showRamenProfile: self.$showRamenProfile, ramen: self.$ramenn).environmentObject(self.authState)
                    HStack {
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
                    List(self.authState.ramens.filter({ searchText.isEmpty ? true : $0.searchableName.contains(searchText)})) { ramen in
//                        Text(ramen.name)
                        NavigationLink(destination: RamenProfile(ramen: ramen, showRamenProfile: .constant(true)).environmentObject(self.authState)) {
                            RamenRow(ramen: ramen)
//                        Text(ramen.name)
                        }
//                            ForEach(self.authState.searchNames.filter{$0.hasPrefix(self.searchText) || self.searchText == ""}, id:\.self) {
//                                searchText in
//                                NavigationLink(destination: RamenProfile(ramen: self.authState.getRamenByName(id: searchText) ).environmentObject(self.authState)) {
//                                    Text(searchText)
//                                }
//                                Button(action: {
//
//                                }) {
//                                    Text(searchText)
//                                }
//                        }
//                        }
                        }
//                    }
//                    .navigationBarTitle("Search Results")
//                    .navigationBarTitle("Back").navigationBarHidden(false)
                } else {
                    VStack(alignment: .leading) {
//                        NavigationView {
                        VStack(alignment: .leading) {
                            Text("Best ramen of the week").bold().font(.title)
                                .padding(.leading)
                            VStack {
                        ForEach(authState.bestRamens) { ramen in
                            NavigationLink(destination: RamenProfile(ramen: ramen, showRamenProfile: .constant(true)).environmentObject(self.authState)) {
                            HStack {
                                Text(ramen.name) .frame(width: 200.0, height: 15.0).padding(.leading, 8.0)
                                StarRating(rating: .constant(Int(ramen.star))).padding(.trailing)
                            }.padding(.bottom)
                            }
                        }
                            }.background(Color.orange.opacity(0.1))
                            VStack(alignment:.leading) {
                                Text("Spice up your week!").bold().font(.title)
                            .padding(.leading)
//spicyRamens is empty!!
                            ForEach(authState.spicyRamens) { ramen in
                                NavigationLink(destination: RamenProfile(ramen: ramen, showRamenProfile:.constant(true)).environmentObject(self.authState)) {
                            
                                HStack {
                                Text(ramen.name) .frame(width: 250.0, height: 35.0).padding(.leading, 8.0)
                                    Spacer().frame(width: 100, height: 25, alignment: .leading)
                                }
                            
                            }
                        }.background(Color.red.opacity(0.2))
                                }

                        }
                        //                        }.navigationBarTitle("Reviews of the week")
                        Spacer()
                        Text("Recommended for You").bold().font(.title).padding(.leading)
                        ScrollView {
                            HStack {
                            Text("Not enough reviews given to calculate! Start a new review now or browse through our collection")
                            }
                        }.padding()
//                        ScrollView {
//                            HStack {
//                            VStack {
//                            RamenIcon(image: Image("nissin"))
//                            Text("Nissin TY")
//                            }.padding([.bottom, .trailing])
//
//                        VStack {
//                        RamenIcon(image: Image("ramen1"))
//                        Text("Doggiemen")
//                        }.padding([.bottom, .trailing])
//
//                        VStack {
//                        RamenIcon(image: Image("ramen1"))
//                        Text("Dogmen x2")
//                        }.padding([.bottom, .trailing])
//                        }.padding()
//                        }
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
        SearchBar(showRamenProfile: .constant(false), ramenn: .constant(Ramen())).environmentObject(AuthenticationState.shared)
//            .environmentObject(Environment())
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


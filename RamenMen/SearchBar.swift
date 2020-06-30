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
    @ObservedObject var ramenModel = RamenViewModel()

    init() {
//        ramenModel.getCategory("searchable name")
        ramenModel.getData()
    }

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
            }
                if isEditing {
//                    NavigationView {
                    Text("Search Result")
                        List(ramenModel.ramens) { ramen in
                        NavigationLink(destination: RamenProfile(ramen: ramen)) {
                            RamenRow(ramen: ramen)
                        }
                        }
//                    }
//                    .navigationBarTitle("Search Results")
//                    .navigationBarTitle("Back").navigationBarHidden(false)
                } else {
                    VStack(alignment: .leading) {
//                        NavigationView {
                            ForEach(ramenModel.ramens) { ramen in
                            NavigationLink(destination: RamenProfile(ramen: ramen)) {
                            HStack {
                                Text(ramen.name) .frame(width: 200.0, height: 10.0).padding(.trailing, 16.0)
                            StarRating(rating: .constant(ramen.star)).padding(.trailing)
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
            Spacer()
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
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


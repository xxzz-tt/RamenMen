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
    @ObservedObject var ramenModel = RamenViewModel()

    init() {
        ramenModel.getCategory("searchable name")
        
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
                        Image(systemName: "multiply.circle.fill").foregroundColor(.gray).padding(.trailing, 8)
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
                List {
                    ForEach(ramenModel.holding.filter{$0.hasPrefix(searchText)}, id:\.self) {
                        searchText in Text(searchText)
                    }
                }
            } else {
            
                HomepageView()
            }
        }.padding(.horizontal)
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


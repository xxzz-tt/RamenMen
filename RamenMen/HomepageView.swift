//
//  HomepageView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @State private var text : String = ""
    
    var body: some View {
            
        VStack {
//            SearchBar()
            
            Spacer()
            
            VStack(alignment: .leading) {
            Text("Today's best ramen")
                .font(.title)
                
                Image("hold").resizable().scaledToFit().padding()
            
            Text("Recommended for You")
                .font(.title)
                
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
                
            }.padding(.leading)
        }
        
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}

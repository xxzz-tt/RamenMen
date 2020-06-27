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
    @State private var isTouched: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            PopularityChart()
        
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
            
        }.padding([.top, .leading])
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}

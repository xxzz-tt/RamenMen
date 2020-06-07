//
//  HomepageView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    
    var body: some View {
            
        VStack {
            SearchBar(text: .constant(""))
            
            ScrollView {
                Text("Today's best ramen")
                    .font(.title)
                
                Spacer()
                
                Text("Recommended for You")
                    .font(.title)
            }
        }
        
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}

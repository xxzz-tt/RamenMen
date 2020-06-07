//
//  RamenProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RamenProfileView: View {
    var body: some View {
        VStack {
            VStack {
                RamenImage(image: Image("ramen1")).padding()
                
                Text("Most famous doggiemen")
                
                HStack(spacing: 70.0) {
                    Text("Average stars:")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    StarRating(rating: .constant(4))
                }
            }.padding()
            
            ScrollView {
                Text("What others say")
                .font(.title)
                .padding(.trailing, 120.0)
            }
        }
    }
}

struct RamenProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfileView()
    }
}

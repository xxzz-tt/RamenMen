//
//  RamenProfileView.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

import SwiftUI

struct RamenProfileView: View {
    var ramen: Ramen
    var body: some View {
        VStack {
            VStack {
                RamenImage(image: Image(ramen.image)).padding()
                
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
                
                HStack {
                    VStack {
                    Image("profilepic").resizable().scaledToFit().frame(width: 70, height: 70, alignment: .leading)
                        
                        Text("R***o")
                    }
                    
                    VStack(alignment: .trailing) {
                        
                        VStack(alignment: .leading) {
                        StarRating(rating: .constant(0))
                        Spacer()
                        
                    Text("Very good! Absolutely 0 star!")
                            Spacer()
                        }
                        
                        Text("Eaten on: 32/13/9102")
                    }
                }
            }
        }
    }
}

struct RamenProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RamenProfileView(ramen: ramenData[0])
    }
}

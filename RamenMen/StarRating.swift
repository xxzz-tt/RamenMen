//
//  StarRating.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
    
    var maximumRating = 5

    var star = Image(systemName: "star.fill")
    
    func image(for number: Int) -> some View {
        
        let color:Color = self.rating < number ? Color.gray : Color.yellow
        return Button(action: {
        }) {
            self.star.imageScale(.large).foregroundColor(color)
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1) { id in
                self.image(for: id)
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: .constant(4))
    }
}

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
    var tappable = true

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        if (self.tappable) {
                            self.rating = number
                        }
                    }
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: .constant(4))
    }
}

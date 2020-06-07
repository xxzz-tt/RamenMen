//
//  RamenImage.swift
//  RamenMen
//
//  Created by XuanZhi on 7/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RamenImage: View {
    var image : Image
    
    var body: some View {
        image.resizable().scaledToFit().frame(width: 300, height: 200, alignment: .center).clipShape(Circle()).overlay(Circle().stroke(Color.orange, lineWidth: 4)).shadow(radius: 8)
    }
}

struct RamenImage_Previews: PreviewProvider {
    static var previews: some View {
        RamenImage(image: Image("ramen1"))
    }
}

//
//  ProfileImage.swift
//  RamenMen
//
//  Created by XuanZhi on 10/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ProfileImage: View {
    var image : Image
    var body: some View {
        image.resizable().scaledToFit().frame(width: 150, height: 150).clipShape(Circle()).overlay(Circle().stroke(Color.white)).shadow(radius: 10)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(image: Image("profilepic"))
    }
}

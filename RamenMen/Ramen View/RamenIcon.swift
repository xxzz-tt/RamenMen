//
//  RamenIcon.swift
//  RamenMen
//
//  Created by XuanZhi on 10/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RamenIcon: View {
    var image : Image
    
    var body: some View {
        image.resizable().frame(width: 60, height: 60, alignment: .center).clipShape(Circle()).overlay(Circle().stroke(Color.orange, lineWidth: 4))
    }
}

struct RamenIcon_Previews: PreviewProvider {
    static var previews: some View {
        RamenIcon(image: Image("nissin"))
    }
}

//
//  RamenRow.swift
//  RamenMen
//
//  Created by XuanZhi on 26/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct RamenRow: View {
    var ramen: RamenTest
    var body: some View {
        HStack(alignment: .center) {
            RamenIcon(image: ramen.image)
            Text(ramen.name)
        }
    }
}

struct RamenRow_Previews: PreviewProvider {
    static var previews: some View {
        RamenRow(ramen: ramen1)
    }
}

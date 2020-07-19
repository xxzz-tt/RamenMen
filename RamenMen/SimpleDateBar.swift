//
//  SimpleDateBar.swift
//  RamenMen
//
//  Created by XuanZhi on 17/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct SimpleDateBar: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    var body: some View {
        VStack {
            Text(" \(Date(), formatter: dateFormatter)").font(.system(size: 30)).fontWeight(.bold).padding()
            }.background(Color.blue.opacity(0.4)).cornerRadius(50)
    }
}

struct SimpleDateBar_Previews: PreviewProvider {
    static var previews: some View {
        SimpleDateBar()
    }
}

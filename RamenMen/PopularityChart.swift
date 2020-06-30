//
//  PopularityChart.swift
//  RamenMen
//
//  Created by XuanZhi on 27/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct PopularityChart: View {
    
    @ObservedObject var ramenModel = RamenViewModel()

    init() {
//        ramenModel.getCategory("name")
        ramenModel.getData()
    }
    
    var body: some View {
        NavigationView {
        VStack(alignment: .leading) {
            ForEach(ramenModel.ramens) { ramen in
                NavigationLink(destination: RamenProfile(ramen: ramen)) {
                HStack {
                    Text(ramen.name) .frame(width: 200.0, height: 10.0)
//                    RamenIcon(image: Image(ramen.image))
                        .padding(.trailing, 16.0)
                    StarRating(rating: .constant(ramen.star))
                        .padding(.trailing)
                }.padding(.bottom)
                }
            }
            Spacer()
            Text("Recommended for You").bold()
            
            ScrollView {
            
            HStack {
                VStack {
                    RamenIcon(image: Image("nissin"))
                    Text("Nissin TY")
                }.padding([.bottom, .trailing])
                
                VStack {
                    RamenIcon(image: Image("ramen1"))
                    Text("Doggiemen")
                }.padding([.bottom, .trailing])
                
                VStack {
                    RamenIcon(image: Image("ramen1"))
                    Text("Dogmen x2")
                }.padding([.bottom, .trailing])
                }.padding()
            }
            }.navigationBarTitle("Rating of the week")
        }
//        List(ramenModel.ramens) { ramen in
//            HStack {
//                Text(ramen.name)
//                Rectangle()
//                .fill(Color.blue)
//                    .frame(width: CGFloat(Double(ramen.star) * 10.0), height: 10.0)
//            }
//        }
    }
}

struct PopularityChart_Previews: PreviewProvider {
    static var previews: some View {
        PopularityChart()
    }
}

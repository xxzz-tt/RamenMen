//
//  Tracker.swift
//  RamenMen
//
//  Created by XuanZhi on 17/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

import SwiftUI

struct Tracker: View {
    @State var progressValue: Float = 0.24
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ProgressBar(progress: self.$progressValue)
                    .frame(width: 200.0, height: 200.0)
                    .padding(.bottom, 45.0)
                    Spacer()
                VStack {
                    
                    Text("You have eaten more ramen than \(Int(progressValue*100))% of the our users in the past month")
                    .padding([.leading, .bottom, .trailing], 30.0)
                }
                
                    SimpleDateBar()
                    .padding(.bottom, 30.0)
                VStack(alignment: .leading) {
                    Text("Health Recommendations for You").font(.system(size: 25)).fontWeight(.semibold)
                    Text("Very healthy! Eat more please").font(.system(size: 25))
                }.padding(.horizontal, 30.0)
                }
            }
        }
    }
}

struct Tracker_Previews: PreviewProvider {
    static var previews: some View {
        Tracker()
    }
}

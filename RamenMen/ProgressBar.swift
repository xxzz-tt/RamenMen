//
//  ProgressBar.swift
//  RamenMen
//
//  Created by XuanZhi on 17/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
            .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
            .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
            .foregroundColor(Color.red).rotationEffect(Angle(degrees: 270.0))
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
            .font(.largeTitle)
            .bold()
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(0.2))
    }
}

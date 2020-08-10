//
//  ProgressView.swift
//  RamenMen
//
//  Created by Xuan Zhi on 27/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import UIKit
import SwiftUI

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.startAnimating()
    }
}

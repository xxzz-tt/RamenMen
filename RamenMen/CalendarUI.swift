//
//  CalendarUI.swift
//  RamenMen
//
//  Created by Xuan Zhi on 20/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

struct CalendarUI: View {
    var body: some View {
        VStack {
            CalController()
            VStack {
                Text("Past Consumption")
            }
        }
    }
}

struct CalendarUI_Previews: PreviewProvider {
    static var previews: some View {
        CalendarUI()
    }
}

struct CalController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CalController>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Calendar", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Cal")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CalController>) {
        
    }
}


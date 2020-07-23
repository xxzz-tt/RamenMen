//
//  AuthenticationType.swift
//  RamenMen
//
//  Created by Xuan Zhi on 22/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import SwiftUI

enum AuthenticationType: String {
    case login
    case signup

    var text: String {
        rawValue.capitalized
    }

    var assetBackgroundName: String {
        self == .login ? "login" : "signup"
    }

    var footerText: String {
        switch self {
            case .login:
                return "Not a member, signup"

            case .signup:
                return "Already a member? login"
        }
    }
}

extension NSError: Identifiable {
    public var id: Int { code }
}

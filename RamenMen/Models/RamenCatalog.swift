//
//  RamenCatalog.swift
//  RamenMen
//
//  Created by X ZZ on 27/7/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import Foundation

struct RamenCatalog {
    private var ramens: [String: [String: AnyObject]]?

    init() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        if let path = Bundle.main.path(forResource: "RamenCatalog", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            ramens = try? PropertyListSerialization.propertyList(from: xml,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: &format) as? [String: [String: AnyObject]]
        }
    }

    public func ramenID(forKey key: String) -> String? {
        // If no items were loaded, return nil for every product.
        guard let ramens = ramens else { return nil }

        if let data = ramens[key] {
            return RamenKey(data: data).ID
        }

        return nil
    }
}

struct RamenKey {
    let ID: String?
    
    init(data: [String: AnyObject]) {
        if let ID = data["id"] as? String {
            self.ID = ID
        } else { self.ID = nil }
    }
}

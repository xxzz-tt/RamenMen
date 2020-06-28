//
//  Data.swift
//  RamenMen
//
//  Created by XuanZhi on 13/6/20.
//  Copyright © 2020 Ramen Men. All rights reserved.
//

import UIKit
import SwiftUI

//let ramenData: [Ramen] = load("RamenData.json")
//let userData: [User] = load("UserData.json")
//let reviewData: [Review] = load("ReviewData.json")
var review11 = ReviewTest(id: 1, user: 1, ramen: 1, star: 2, value: 2, spicy: 3, comments: "no comments")
var review21 = ReviewTest(id: 2, user: 2, ramen: 1, star: 4, value: 1, spicy: 3, comments: "hng")
var review31 = ReviewTest(id: 3, user: 2, ramen: 1, star: 3, value: 1, spicy: 3, comments: "bleh shdiahdajsjfkhsadlajsdkahfahdalsdnsjhg")

var review1 = Review(id: "111", userId: "2", ramenId: "ahdh232", star: 3, value: 2, spicy: 3, comments: "no comments")
var review2 = Review(id: "211", userId: "2", ramenId: "ahdh232", star: 4, value: 1, spicy: 3, comments: "hnnng")

var reviewArray = [review11, review21, review31]
var ramen1 = Ramen(id: "ahdh232", brand: "nissin", name: "chicken noodle", style: "Bowl", image: "nissin", searchableName: "", star: 4, spiciness: 0, reviews: [review1.id, review2.id])
var user2 = UserTest(id: 2, username: "user2", image: Image("profile pic"), reviews: [review21, review31])

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

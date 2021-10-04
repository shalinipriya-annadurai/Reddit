//
//  FeedModel.swift
//  Reddit
//
//  Created by Shalinipriya Annadurai on 10/2/21.
//

import Foundation

struct Feed {
    let title: String?
    let comments: Int?
    let thumbnail: String?
    let score: Int?
    
    var imageURL: URL? {
        return URL(string: self.thumbnail ?? "")
    }
}

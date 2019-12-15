//
//  PostModel.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import Foundation
import Siesta

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init() {
        self.userId = 0
        self.id = 0
        self.title = "no title"
        self.body = "no body"
    }
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

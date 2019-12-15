//
//  APIService.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import Foundation
import Siesta

enum EndPoint {
    static let posts = "/posts"
}

protocol ServiceProtocol {
    var posts: Resource { get }
}

class APIService: Service, ServiceProtocol {
    
    private let api = Service(baseURL: "https://jsonplaceholder.typicode.com", standardTransformers: [.text, .image])
    private func post(id: String) -> Resource {
        return posts.child(id)
    }
    
    init() {
        let decoder = JSONDecoder()
        self.api.configureTransformer(EndPoint.posts) { e -> [Post] in
            try decoder.decode([Post].self, from: e.content)
        }
    }
    
    // MARK: - ServiceProtocol
    var posts: Resource { return api.resource(EndPoint.posts) }
}

let apiService = APIService()

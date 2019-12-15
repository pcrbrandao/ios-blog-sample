//
//  ios_blog_sampleTests.swift
//  ios-blog-sampleTests
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import XCTest
@testable import ios_blog_sample

class ios_blog_sampleTests: XCTestCase {
    var errorHandler: ErrorProtocol!
    var localStorage: LocalStorageProtocol!

    override func setUp() {
        errorHandler = OnloadError()
        localStorage = CoreDataStorage(errorHandler: errorHandler)
    }

    override func tearDown() {
    }

    func testLocalStorageMustReturnAValidPostList() {
        let posts = localStorage.posts()
        print("Existem \(posts.count) post(s)")
        XCTAssertNotNil(posts)
    }
    
    func testLocalStorageMustReturnABlankList() {
        localStorage.deleteAllPosts()
        XCTAssert(localStorage.posts().count == 0)
    }
}

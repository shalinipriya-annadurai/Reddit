//
//  FeedsTest.swift
//  RedditTests
//
//  Created by Shalinipriya Annadurai on 10/4/21.
//

import XCTest
@testable import Reddit

class FeedsTest: XCTestCase {
    
    func testInit(){
        let feed = Feed(title: "I am the champion", comments: 340, thumbnail: nil, score: 456)
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed.title)
        XCTAssertNotNil(feed.comments)
        XCTAssertNotNil(feed.score)
        XCTAssertNil(feed.thumbnail)

    }
    
    func testDownloadWebData() {
        
        let expectation = XCTestExpectation(description: "Download RSS feeds")
        let url = URL(string: "http://www.reddit.com/.json")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
        }
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}

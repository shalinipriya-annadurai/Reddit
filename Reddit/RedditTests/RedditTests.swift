//
//  RedditTests.swift
//  RedditTests
//
//  Created by Shalinipriya Annadurai on 10/1/21.
//

import XCTest
@testable import Reddit

class ViewControllerTests: XCTestCase {

    func testIfViewcontrollerHasTableView() {
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self)).instantiateInitialViewController() as? ViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.tableView, "Couln't load tableview")
        XCTAssertNotNil(controller.tableView.delegate, "tableview delegate is nil")
    }
}

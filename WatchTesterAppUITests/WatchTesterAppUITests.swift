//
//  WatchTesterAppUITests.swift
//  WatchTesterAppUITests
//
//  Created by Zhanna Moskaliuk on 13.10.2021.
//

import XCTest

class WatchTesterAppUITests: XCTestCase {

    let timeout: TimeInterval = 60 * 60 * 24
    
    private var expectation: XCTestExpectation?
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        expectation = XCTestExpectation(description: "All tests are finished.")
        
        continueAfterFailure = false
       
        app.launch()
    }
    
    func testLaunch() {
        print("App should launch")
//        app.buttons["start"].tap()
        wait(for: [expectation!], timeout: timeout)
    }
}

//
//  WatchTesterApp_WatchKit_AppUITests.swift
//  WatchTesterApp WatchKit AppUITests
//
//  Created by Zhanna Moskaliuk on 13.10.2021.
//

import XCTest

class WatchTesterApp_WatchKit_AppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
       
        app.launch()
    }

    func testLaunc() {
        print("App should launch")
        app.buttons["start"].tap()
        //
    }
}

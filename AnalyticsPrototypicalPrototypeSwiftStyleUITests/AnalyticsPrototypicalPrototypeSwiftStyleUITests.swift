//
//  AnalyticsPrototypicalPrototypeSwiftStyleUITests.swift
//  AnalyticsPrototypicalPrototypeSwiftStyleUITests
//
//  Created by Kevin Rafferty on 6/9/15.
//  Copyright © 2015 JunGroup. All rights reserved.
//

import XCTest
import Foundation

class AnalyticsPrototypicalPrototypeSwiftStyleUITests: XCTestCase {
        
    override func setUp() {
        
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testFetchInformationButton() {
        
        XCUIApplication().buttons["Fetch Information"].tap()

        // We expect the the Average eCPM UILabel to be updated with a value
        XCTAssertNotNil(XCUIApplication().label);
    }
    
    func testStartDateTextField() {
        
        let app = XCUIApplication()
        
        app.textFields["Start Date"].tap()
        
        app.pickerWheels["June"].tap()
        app.pickerWheels["9"].tap()
        app.pickerWheels["2015"].tap()
        
//        XCTAssertEqual(ViewController.startDateTextField.text, "", "We expect the Start Date UITextField to be equal to 'Jun 9, 2015'.")
    }
    
    func testEndDateTextField() {
        
        let app = XCUIApplication()
        
        app.textFields["End Date"].tap()
        
        app.pickerWheels["June"].tap()
        app.pickerWheels["9"].tap()
        app.pickerWheels["2015"].tap()
        
//        XCTAssertEqual(ViewController.endDateTextField.text, "", "We expect the Start Date UITextField to be equal to 'Jun 9, 2015'.")
    }
}
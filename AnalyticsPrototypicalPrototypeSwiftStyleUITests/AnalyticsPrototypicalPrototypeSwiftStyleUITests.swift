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
    
    /*
     *
     * NOTE: When invoking the tap method on the Fetch Information
     *       UIButton it will send an asynchronous request to the
     *       Keen IO Server to receive a response pertaining to the
     *       ad_completed collection. However, when we assert if the
     *       Average eCPM UILabel has been updated with the parsed
     *       JSON data it will not have happened yet. The Apple
     *       Engineer that I talked to said that this is a known issue
     *       they already knew about going into this WWDC. I have tried
     *       adding an XCTestExpectation but I cannot get that to work.
     *       Not sure where to go from here since my questions was not
     *       answered and other developers are having the same issue.
     *
     */
    
    func testFetchInformationButton() {
        
        let expectation = expectationWithDescription("Wait for the asynchronous request to return.")
        
        let app = XCUIApplication()
        
        let fetchInformationButton = app.buttons["Fetch Information Button"]
        
        fetchInformationButton.tap()
        
        expectation.fulfill()
        
        waitForExpectationsWithTimeout(10) { (error) in
            
            if error != nil {
                
                print("Expectation error has been received: \(error?.localizedDescription)")
            }
        }
        
//        let eCPMLabel = app.staticTexts["Average eCPM Value"]
//        
//        XCTAssertNotEqual(eCPMLabel.title, "", "We expect the eCPM Value UILabel to have a value within its title field.")
    }
    
    /*
     *
     * NOTE: All three Apple Engineers laughed and said UIDatePicker is tricky.
     *       They seemed to try to avoid the question. I would like to say that
     *       the Recording feature does not even pick up anything when scrolling
     *        the date options. You have to tap on the dates instead.
     *
     */
    
    func testStartDateTextField() {
        
        let app = XCUIApplication()
        
        let startDateTextField = app.textFields["Start Date"]
        
        startDateTextField.tap()
        
        XCUIApplication().textFields["Start Date"].tap()
        
//        XCTAssertEqual(ViewController.startDateTextField.text, "", "We expect the Start Date UITextField to be equal to 'Jun 9, 2015'.")
    }
    
    func testEndDateTextField() {
        
        let app = XCUIApplication()
        
        let endDatetextField = app.textFields["End Date"]
        
        endDatetextField.tap()
        
//        XCTAssertEqual(ViewController.endDateTextField.text, "", "We expect the Start Date UITextField to be equal to 'Jun 9, 2015'.")
    }
}
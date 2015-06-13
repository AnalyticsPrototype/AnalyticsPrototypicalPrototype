//
//  AnalyticsPrototypicalPrototypeSwiftStyleTests.swift
//  AnalyticsPrototypicalPrototypeSwiftStyleTests
//
//  Created by Kevin Rafferty on 6/9/15.
//  Copyright © 2015 JunGroup. All rights reserved.
//

import XCTest
import OHHTTPStubs

class AnalyticsPrototypicalPrototypeSwiftStyleTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testParsingProperJSON() {
        
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.host == "mywebservice.com"}) { _ in
            
            return OHHTTPStubsResponse(fileAtPath:OHPathForFile("ad_completedJSON.json", self.dynamicType)!, statusCode:200, headers:["Content-Type":"application/json"])
        }
        
        let expectation = expectationWithDescription("We expect the stubbed proper JSON to be parsed correctly.")
        
        ViewController().retrieveAdCompletedInformation()
        
        expectation.fulfill()
        
        waitForExpectationsWithTimeout(10) { (error) in
            
            if error != nil {
                
                print("testParsingProperJSON expectation ERROR - \(error?.localizedDescription)")
            }
        }
    }
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measureBlock() {
            
            
        }
    }
}
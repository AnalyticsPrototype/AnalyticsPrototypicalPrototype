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
    
    func testExample() {
        
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.host == "mywebservice.com"}) { _ in
            
            let obj = ["key1": "value1", "key2":["value2A","value2B"]]
            
            return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil)
        }
    }
    
//    func testPerformanceExample() {
//        
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            
//            
//        }
//    }
}
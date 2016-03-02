//
//  SocketDemoTests.swift
//  SocketDemoTests
//
//  Created by 李伟超 on 16/2/24.
//  Copyright © 2016年 LWC. All rights reserved.
//

import XCTest
@testable import SocketDemo

class SocketDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        let date = NSDate()
        self.measureBlock() {
            let string = dateFormatter.stringFromDate(date)
            NSLog("=======%@", string)
        }
    }
}

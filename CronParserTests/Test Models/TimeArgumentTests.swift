//
//  TimeArgumentTests.swift
//  CronParserTests
//
//  Created by Ruben Exposito Marin on 2/9/22.
//

import XCTest

class TimeArgumentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    
    func testInit_TimeArgument() {
        let timeArgument = TimeArgument(time: "16:10")
        
        XCTAssertNotNil(timeArgument)
        XCTAssertEqual(timeArgument.time, "16:10")
    }
    
    // MARK: isValid function
    
    func testTimeArgument_IsValid_ReturnsFalseForNotValidString() {
        let timeArgument = TimeArgument.isValid("16:*")
        
        XCTAssertEqual(timeArgument, false)
    }
    
    func testTimeArgument_IsValid_ReturnsTrueForValidString() {
        let timeArgument = TimeArgument.isValid("16:10")
        
        XCTAssertEqual(timeArgument, true)
    }
}

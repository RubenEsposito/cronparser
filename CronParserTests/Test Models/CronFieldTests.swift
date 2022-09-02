//
//  CronFieldTests.swift
//  CronParserTests
//
//  Created by Ruben Exposito Marin on 2/9/22.
//

import XCTest

class CronFieldTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    
    func testInit_CronField() {
        let cronField = CronField(hours: "16", minutes: "10", command: "/bin/run_me_daily")
        
        XCTAssertNotNil(cronField)
        XCTAssertEqual(cronField.hours, "16")
        XCTAssertEqual(cronField.minutes, "10")
        XCTAssertEqual(cronField.command, "/bin/run_me_daily")
    }
    
    // MARK: isValidHours function
    
    func testCronField_IsValidHours_ReturnsFalseForNotValidString() {
        let isValid = CronField.isValidHours("-")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_IsValidHours_ReturnsFalseForNotValidNumber() {
        let isValid = CronField.isValidHours("12.6")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_IsValidHours_ReturnsFalseForTooBigHours() {
        let isValid = CronField.isValidHours("25")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_IsValidHours_ReturnsTrueForValidString() {
        let isValid = CronField.isValidHours("*")
        
        XCTAssertEqual(isValid, true)
    }
    
    func testCronField_IsValidHours_ReturnsTrueForValidHours() {
        let isValid = CronField.isValidHours("16")
        
        XCTAssertEqual(isValid, true)
    }
    
    // MARK: isValidMinutes function
    
    func testCronField_isValidMinutes_ReturnsFalseForNotValidString() {
        let isValid = CronField.isValidMinutes("-")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_isValidMinutes_ReturnsFalseForNotValidNumber() {
        let isValid = CronField.isValidMinutes("10.1")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_isValidMinutes_ReturnsFalseForTooBigHours() {
        let isValid = CronField.isValidMinutes("61")
        
        XCTAssertEqual(isValid, false)
    }
    
    func testCronField_isValidMinutes_ReturnsTrueForValidString() {
        let isValid = CronField.isValidMinutes("*")
        
        XCTAssertEqual(isValid, true)
    }
    
    func testCronField_isValidMinutes_ReturnsTrueForValidHours() {
        let isValid = CronField.isValidMinutes("10")
        
        XCTAssertEqual(isValid, true)
    }
    
    // MARK: Equatable
    
    func testEquatable_ReturnsTrue() {
        let field1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
        let field2 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
        
        XCTAssertEqual(field1, field2)
    }
    
    func testEquatable_ReturnsNotEqualForDifferentHours() {
        let field1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
        let field2 = CronField(hours: "2", minutes: "30", command: "/bin/run_me_daily")
        
        XCTAssertNotEqual(field1, field2)
    }
    
    func testEquatable_ReturnsNotEqualForDifferentMinutes() {
        let field1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
        let field2 = CronField(hours: "1", minutes: "31", command: "/bin/run_me_daily")
        
        XCTAssertNotEqual(field1, field2)
    }
    
    func testEquatable_ReturnsNotEqualForDifferentCommands() {
        let field1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
        let field2 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_hourly")
        
        XCTAssertNotEqual(field1, field2)
    }
    
    // MARK: nextExecutionTime
    
    func testCronField_NextExecutionTime_() {
        
    }
}

//
//  CronFieldParserTests.swift
//  CronParserTests
//
//  Created by Ruben Exposito Marin on 2/9/22.
//

import XCTest

class CronFieldParserTests: XCTestCase {

    var sut: CronFieldParser!
    
    let cronField1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
    let cronField2 = CronField(hours: "*", minutes: "45", command: "/bin/run_me_hourly")
    let cronField3 = CronField(hours: "*", minutes: "*", command: "/bin/run_me_every_minute")
    let cronField4 = CronField(hours: "19", minutes: "*", command: "/bin/run_me_sixty_times")
    
    override func setUpWithError() throws {
        sut = CronFieldParser()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Parsing functions
    
    func testCronField_ParseCronField_ReturnsCronFieldForValidInput() {
        let input = "30 1 /bin/run_me_daily"

        let result = sut.parseCronField(from: input)
        XCTAssertEqual(result, cronField1)
    }
    
    func testCronField_ParseCronField_ReturnsErrorForIncorrectNumberOfElements() {
        let input = "30 1\n/bin/run_me_daily"

        let result = sut.parseCronField(from: input)
        XCTAssertEqual(result, nil)
    }
    
    func testCronField_ParseCronField_ReturnsErrorForNotValidHours() {
        let input = "30 - /bin/run_me_daily"

        let result = sut.parseCronField(from: input)
        XCTAssertEqual(result, nil)
    }
    
    func testCronField_ParseCronField_ReturnsErrorForNotValidMinutes() {
        let input = "- 1 /bin/run_me_daily"

        let result = sut.parseCronField(from: input)
        XCTAssertEqual(result, nil)
    }
    
    func testCronField_LoadCronFieldFromArray_ReturnsCorrectCronFieldsArray() {
        let input = ["30 1 /bin/run_me_daily",
        "45 * /bin/run_me_hourly",
        "* * /bin/run_me_every_minute",
        "* 19 /bin/run_me_sixty_times"]

        let result = sut.loadCronFields(from: input)
        XCTAssertEqual(result[0], cronField1)
        XCTAssertEqual(result[1], cronField2)
        XCTAssertEqual(result[2], cronField3)
        XCTAssertEqual(result[3], cronField4)
    }

}

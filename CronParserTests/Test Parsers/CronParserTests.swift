//
//  CronParserTests.swift
//  CronParserTests
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import XCTest

class CronParserTests: XCTestCase {

    var sut: CronParser!
    
    let cronField1 = CronField(hours: "1", minutes: "30", command: "/bin/run_me_daily")
    let cronField2 = CronField(hours: "*", minutes: "45", command: "/bin/run_me_hourly")
    let cronField3 = CronField(hours: "*", minutes: "*", command: "/bin/run_me_every_minute")
    let cronField4 = CronField(hours: "19", minutes: "*", command: "/bin/run_me_sixty_times")
    
    override func setUpWithError() throws {
        sut = CronParser()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: calculateNextExecutionTimes
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsEmptyIfNoTimeArgument() {
        let executionTimes = sut.calculateNextExecutionTimes()
        
        XCTAssertEqual(executionTimes, [])
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsTimesIfTimeArgument() {
        let timeArgument = TimeArgument(time: "16:10")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField1]
        let executionTimes = sut.calculateNextExecutionTimes()
        
        XCTAssertNotEqual(executionTimes, [])
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsSameTimeTodayForBothAsterisks() {
        let timeArgument = TimeArgument(time: "16:10")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField3]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "16:10")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsOneHourMoreAndTodayForHourAsteriskAndLessMinutesForCronField() {
        let timeArgument = TimeArgument(time: "16:50")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField2]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "17:50")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCurrentHoursCronMinutesAndTodayForHourAsteriskAndEqualOrMoreMinutesForCronField() {
        let timeArgument = TimeArgument(time: "16:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField2]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "16:45")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHours00MinutesAndTomorrowForMinutesAsteriskAndLessHoursForCronField() {
        let timeArgument = TimeArgument(time: "20:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField4]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "19:00")
        XCTAssertEqual(components[1], "tomorrow")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHours00MinutesAndTodayForMinutesAsteriskAndMoreHoursForCronField() {
        let timeArgument = TimeArgument(time: "18:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField4]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "19:00")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHoursCurrentMinutesAndTodayForMinutesAsteriskAndEqualHoursForCronField() {
        let timeArgument = TimeArgument(time: "19:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField4]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "19:40")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHoursCronMinutesAndTomorrowForLessHoursForCronField() {
        let timeArgument = TimeArgument(time: "2:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField1]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "1:30")
        XCTAssertEqual(components[1], "tomorrow")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHoursCronMinutesAndTodayForMoreHoursForCronField() {
        let timeArgument = TimeArgument(time: "0:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField1]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "1:30")
        XCTAssertEqual(components[1], "today")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHoursCronMinutesAndTomorrowForSameHoursAndLessMinutesForCronField() {
        let timeArgument = TimeArgument(time: "1:40")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField1]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "1:30")
        XCTAssertEqual(components[1], "tomorrow")
    }
    
    func testCronParser_CalculateNextExecutionTimes_ReturnsCronHoursCronMinutesAndTomorrowForSameHoursAndSameOrMoreMinutesForCronField() {
        let timeArgument = TimeArgument(time: "1:30")
        sut.timeArgument = timeArgument
        sut.cronFields = [cronField1]
        let executionTimes: [String] = sut.calculateNextExecutionTimes()
        
        let components = executionTimes[0].components(separatedBy: " ")
        
        XCTAssertEqual(components[0], "1:30")
        XCTAssertEqual(components[1], "today")
    }
}

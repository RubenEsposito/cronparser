//
//  CronParser.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

enum OptionType: String {
    case help = "h"
    case time
    case unknown
    
    init(value: String) {
        if value == "-h" {
            self = .help
        } else if TimeArgument.isValid(value) {
            self = .time
        } else {
            self = .unknown
        }
    }
}

class CronParser {
    let consoleIO = ConsoleIO()
    var timeArgument: TimeArgument?
    var cronFields = [CronField]()
    private var argument: String?
    
    func start() {
        readInput()
        readArgument()
        processArgument()
        calculateNextExecutionTimes()
    }
    
    private func readInput() {
        let cronFieldParser = CronFieldParser()
        
        let input = consoleIO.getInput()
        cronFields = cronFieldParser.loadCronFields(from: input)
    }
    
    private func readArgument() {
        argument = CommandLine.arguments[1]
    }
    
    private func processArgument() {
        guard let argument = argument else { return }
        
        let (option, value) = getOption(argument)
        
        switch option {
        case .time:
            timeArgument = TimeArgument(time: value)
        case .help:
            consoleIO.printUsage()
        case .unknown:
            consoleIO.writeMessage("Unknown option \(value)")
            consoleIO.printUsage()
        }
    }
    
    private func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
    @discardableResult func calculateNextExecutionTimes() -> [String] {
        guard let currentTime = timeArgument?.time else { return [] }
        
        var executionTimes: [String] = []
        
        for cronField in cronFields {
            let nextExecutionTime = cronField.nextExecutionTime(forCurrentTime: currentTime)
            executionTimes.append(nextExecutionTime)
            consoleIO.writeMessage(nextExecutionTime)
        }
        return executionTimes
    }
}

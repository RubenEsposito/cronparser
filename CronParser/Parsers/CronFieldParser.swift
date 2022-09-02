//
//  CronFieldParser.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

class CronFieldParser {
    let consoleIO = ConsoleIO()
    
    func loadCronFields(from array: [String]) -> [CronField] {
        return array.compactMap { field in
            return parseCronField(from: field)
        }
    }
    
    func parseCronField(from field: String) -> CronField? {
        let components = field.components(separatedBy: " ")
        
        guard components.count == 3 else {
            consoleIO.writeMessage("Invalid input format", to: .error)
            return nil
        }
        
        let minutes = components[0]
        let hours = components[1]
        let command = components[2]
        
        guard CronField.isValidMinutes(minutes),
              CronField.isValidHours(hours) else {
            consoleIO.writeMessage("Invalid input format", to: .error)
            return nil
        }
        
        return CronField(hours: hours, minutes: minutes, command: command)
    }
}

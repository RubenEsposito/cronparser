//
//  CronField.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

struct CronField: Equatable {
    let hours: String
    let minutes: String
    let command: String
    
    static func isValidHours(_ input: String) -> Bool {
        guard let number = Int(input),
              number >= 0,
              number < 24 else {
            if input == "*" {
                return true
            }
            return false
        }
        return true
    }
    static func isValidMinutes(_ input: String) -> Bool {
        guard let number = Int(input),
              number >= 0,
              number < 60 else {
            if input == "*" {
                return true
            }
            return false
        }
        return true
    }
    
    func nextExecutionTime(forCurrentTime time: String) -> String {
        let timeComponents = time.components(separatedBy: CharacterSet.punctuationCharacters)
        guard let currentHours = Int(timeComponents[0]),
              let currentMinutes = Int(timeComponents[1]) else { return "" }
        
        var retHours = ""
        var retMinutes = ""
        var todayOrTomorrow = ""
        
        if hours  == "*", minutes == "*" {
            retHours = String(currentHours)
            retMinutes = String(currentMinutes)
            todayOrTomorrow = "today"
        } else if hours  == "*" {
            if let fieldMinutes = Int(minutes),
               fieldMinutes < currentMinutes {
                retHours = String(currentHours + 1)
                retMinutes = String(currentMinutes)
                todayOrTomorrow = "today"
            } else {
                retHours = String(currentHours)
                retMinutes = minutes
                todayOrTomorrow = "today"
            }
        } else if minutes == "*", let fieldHours = Int(hours) {
            if fieldHours < currentHours {
                retHours = hours
                retMinutes = "00"
                todayOrTomorrow = "tomorrow"
            } else if fieldHours > currentHours {
                retHours = hours
                retMinutes = "00"
                todayOrTomorrow = "today"
            } else {
                retHours = hours
                retMinutes = String(currentMinutes)
                todayOrTomorrow = "today"
            }
        } else if let fieldHours = Int(hours),
                  let fieldMinutes = Int(minutes) {
            if fieldHours < currentHours {
                retHours = hours
                retMinutes = minutes
                todayOrTomorrow = "tomorrow"
            } else if fieldHours > currentHours {
                retHours = hours
                retMinutes = minutes
                todayOrTomorrow = "today"
            } else {
                if fieldMinutes < currentMinutes{
                    retHours = hours
                    retMinutes = minutes
                    todayOrTomorrow = "tomorrow"
                } else {
                    retHours = hours
                    retMinutes = minutes
                    todayOrTomorrow = "today"
                }
            }
        }
        
        return "\(retHours):\(retMinutes) \(todayOrTomorrow) - \(command)"
    }
}

func==(lhs: CronField, rhs: CronField) -> Bool {
    if lhs.hours != rhs.hours {
        return false
    }
    
    if lhs.minutes != rhs.minutes {
        return false
    }
    
    if lhs.command != rhs.command {
        return false
    }
    return true
}

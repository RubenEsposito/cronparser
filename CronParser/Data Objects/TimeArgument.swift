//
//  TimeArgument.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

struct TimeArgument {
    let time: String?
    
    static func isValid(_ input: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        return dateFormatterGet.date(from: input) != nil
    }
}

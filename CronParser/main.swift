//
//  main.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

let cronParser = CronParser()
let consoleIO = ConsoleIO()

if CommandLine.argc < 2 {
    consoleIO.printUsage()
} else {
    cronParser.start()
}


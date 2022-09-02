//
//  ConsoleIO.swift
//  CronParser
//
//  Created by Ruben Exposito Marin on 1/9/22.
//

import Foundation

// stdout and stderr representations
enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
    
    func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) [simulated current time in HH:MM format]")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
    
    func getInput() -> [String] {
        let input = FileHandle.standardInput
        let inputData = input.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.components(separatedBy: CharacterSet.newlines).filter{ !$0.isEmpty }
    }
}

//
//  RunFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class RunFunction: Function, Helpful {
    init() {
        super.init(identifier: "^run \\S+", name: "run")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        let elements = command.elements
        let program = elements[1]
        let formattedProgramName = program.lowercaseString
        
        if program.characters.count == 0 {
            completion(response: "Program name not specified.")
        }
        else {
            if formattedProgramName == "calculator" {
                TerminalViewController.currentInstance.currentProgram = Calculator()
            }
            else {
                completion(response: program + " is not a valid program.")
                return
            }
        }
        
        completion(response: nil)
    }
    
    func help() -> String {
        return "run help"
    }
}

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
    
    override func execute(command: String) -> String? {
        let program = command.stringByReplacingOccurrencesOfString("run ", withString: "").lowercaseString
        
        if program.characters.count == 0 {
            return "Program name not specified."
        }
        else {
            if program == "calculator" {
                TerminalViewController.currentProgram = Calculator()
            }
            else {
                return program + " is not a valid program."
            }
        }
        
        return nil
    }
    
    func help() -> String {
        return "run help"
    }
}

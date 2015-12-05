//
//  HelpFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/3/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class HelpFunction: Function {
    var helpText: String
    var functions: [Function]
    
    init(programHelpText: String, regisertedFunctions: [Function]) {
        self.helpText = programHelpText
        self.functions = regisertedFunctions
        
        super.init(identifier: "^help[ ]?\\S*", name: "help")
    }
    
    override func execute(command: String) -> String? {
        if command == "help" {
            return helpText
        }
        else {
            let rangeOfSpaceInCommand = command.rangeOfString(" ")
            let functionName = command.substringFromIndex((rangeOfSpaceInCommand?.endIndex)!)
            
            let helpfulFunctions = functions.filter({ (function) -> Bool in
                return function is Helpful
            })
                
            for function in helpfulFunctions {
                if function.name == functionName {
                    let helpfulFunction = function as! Helpful
                    return helpfulFunction.help()
                }
            }
            
            return "Function does not exist."
        }
    }
}

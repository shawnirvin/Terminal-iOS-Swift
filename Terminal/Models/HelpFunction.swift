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
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        if command.rawValue.lowercaseString == "help" {
            completion(response: helpText)
        }
        else {
            let rangeOfSpaceInCommand = command.rawValue.rangeOfString(" ")
            let functionName = command.rawValue.substringFromIndex((rangeOfSpaceInCommand?.endIndex)!)
            
            let helpfulFunctions = functions.filter({ (function) -> Bool in
                return function is Helpful
            })
                
            for function in helpfulFunctions {
                if function.name == functionName {
                    let helpfulFunction = function as! Helpful
                    completion(response: helpfulFunction.help())
                    
                    return
                }
            }
            
            completion(response: "Function does not exist or does not support the help function.")
        }
    }
}

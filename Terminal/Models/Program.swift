//
//  Program.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class Program: NSObject, Helpful {
    var name: String
    var completionBlock: ((response: String?) -> Void)?
    private lazy var functions: [Function] = [EndFunction(), ClearFunction(), HelpFunction(programHelpText: self.help(), regisertedFunctions: [Function]())]
    
    init(name: String) {
        self.name = name
    }
    
    func registerFunction(function: Function) {
        self.functions.append(function)
        
        for function in self.functions {
            if let helpFunction = function as? HelpFunction {
                helpFunction.functions = self.functions
            }
        }
    }
    
    func unregisterFunction(functionToRemove: Function) {
        for function in self.functions {
            if function == functionToRemove {
                self.functions.removeAtIndex(self.functions.indexOf(function)!)
            }
        }
    }
    
    func registeredFunctions() -> [Function] {
        return self.functions
    }
    
    func runCommand(command: Command, completion: (response: String?) -> Void) {
        if let function = functionForCommand(command) {
            function.execute(command, completion: completion)
        }
        else {
            completion(response: nil)
        }
    }
    
    func functionForCommand(command: Command) -> Function? {
        for function in functions {
            if function.equals(command) {
                return function
            }
        }
        
        return nil
    }
    
    func help() -> String {
        let help = "Each program contains it's own help menu. Type 'help' while running a program to see the help for that program.\n" +
                    "\tType 'help name' to find out more about the function 'name' (if available).\n\n"
        
        return help
    }
}
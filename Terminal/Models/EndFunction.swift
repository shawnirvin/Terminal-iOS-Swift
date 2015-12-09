//
//  EndFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/3/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class EndFunction: Function, Helpful {
    init() {
        super.init(identifier: "^end", name: "end")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        if (TerminalViewController.currentInstance.currentProgram.name == "System") {
            completion(response: "Not currently running a program.")
        }
        else {
            TerminalViewController.currentInstance.currentProgram = MainProgram()
            completion(response: nil)
        }
    }
    
    func help() -> String {
        return "end help"
    }
}

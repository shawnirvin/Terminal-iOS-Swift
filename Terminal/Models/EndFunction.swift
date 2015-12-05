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
    
    override func execute(command: String) -> String? {
        if (TerminalViewController.currentProgram.name == "System") {
            return "Not currently running a program."
        }
        else {
            TerminalViewController.currentProgram = MainProgram()
            return nil
        }
    }
    
    func help() -> String {
        return "end help"
    }
}

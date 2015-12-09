//
//  Calculator.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class Calculator: Program {
    init() {
        super.init(name: "Calculator")
    }
    
    override func runCommand(command: Command, completion: (response: String?) -> Void) {
        super.runCommand(command, completion: completion)
    }
}

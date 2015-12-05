//
//  MainProgram.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class MainProgram: Program {
    init() {
        super.init(name: "System")
        
        loadFunctions()
    }
    
    private func loadFunctions() {
        self.registerFunction(RunFunction())
        self.registerFunction(DefaultsFunction())
    }
    
    override func help() -> String {
        var help = super.help()
        
        help = help +
            "\trun\t\t[program]"
        
        return help
    }
}

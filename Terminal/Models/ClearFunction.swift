//
//  ClearFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/8/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class ClearFunction: Function, Helpful {
    init() {
        super.init(identifier: "^clear", name: "clear")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        TerminalViewController.currentInstance.terminalTextView.clear()
        
        completion(response: nil)
    }
    
    func help() -> String {
        return ""
    }
}

//
//  TimerFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/9/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

class TimerFunction: Function {
    init() {
        super.init(identifier: "^timer (\\d+|stop)", name: "timer")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        let term = command.elements[1]
        
        if term == "stop" {
            
        }
        else {
            
        }
    }
    
    func setTimer(value: Int) {
        
    }
}

//
//  DefaultsFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/4/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class DefaultsFunction: Function, Helpful {
    init() {
        super.init(identifier: "^defaults (write|read) \\S+.*", name: "defaults")
    }
    
    override func execute(command: String) -> String? {
        return "test"
    }
    
    func help() -> String {
        return ""
    }
}

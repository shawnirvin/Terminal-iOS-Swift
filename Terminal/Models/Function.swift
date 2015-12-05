//
//  Function.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

class Function: NSObject {
    var identifier: String
    var name: String
    
    init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
    
    func execute(command: String) -> String? {
        return nil
    }
    
    func equals(command: String) -> Bool {
        if let expression = try? NSRegularExpression.init(pattern: self.identifier, options: .CaseInsensitive) {
            let matches = expression.matchesInString(command, options: .Anchored, range: NSMakeRange(0, command.characters.count))
            
            if matches.count == 1 {
                return true
            }
            else {
                 return false
            }
        }
        else {
            return false
        }
    }
}

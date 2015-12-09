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
    var completionBlock: ((response: String?) -> Void)?
    
    init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
    
    func execute(command: Command, completion: (response: String?) -> Void) {
        completion(response: nil)
    }
    
    func equals(command: Command) -> Bool {
        if let expression = try? NSRegularExpression.init(pattern: self.identifier, options: .CaseInsensitive) {
            let matches = expression.matchesInString(command.rawValue, options: .Anchored, range: NSMakeRange(0, command.rawValue.characters.count))
            
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

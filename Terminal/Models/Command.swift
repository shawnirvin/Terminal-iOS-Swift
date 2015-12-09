//
//  Command.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/6/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import Foundation

extension String {
    func split(key: String) -> [String] {
        var elements = [String]()
        
        if let _ = self.rangeOfString(" ") {
            var str = self
            
            while str.characters.count > 0 {
                var word = str
                
                if let rangeOfSpace = str.rangeOfString(" ") {
                    word = str.substringToIndex(rangeOfSpace.endIndex.advancedBy(-1))
                    
                    if rangeOfSpace.endIndex.distanceTo(str.endIndex) > 0 {
                        str = str.substringFromIndex(rangeOfSpace.endIndex)
                    }
                }
                else {
                    str = ""
                }
                
                elements.append(word)
            }
        }
        else {
            elements.append(self)
        }
        
        return elements
    }
}

class Command: NSObject {
    var rawValue: String {
        didSet {
            self.elements = parseElements()
        }
    }
    
    lazy var elements: [String] = { [unowned self] in
        return self.parseElements()
    }()
    
    init(rawInput: String) {
        self.rawValue = rawInput
    }
    
    private func parseElements() -> [String] {
        let elements = self.rawValue.split(" ")
        
        return elements
    }
}

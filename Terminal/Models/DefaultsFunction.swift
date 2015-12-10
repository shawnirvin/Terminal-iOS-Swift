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
        super.init(identifier: "^defaults (write \\S+.*|read \\S+.*|restore)", name: "defaults")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        if command.rawValue.lowercaseString == "defaults restore" {
            TerminalViewController.currentInstance.terminalTextView.getInput("Type 1 to confirm, 0 to cancel: ", inputType: .Normal) { input in
                var output = ""
                
                if input == "1" {
                    Setting.restoreDefaults()
                    output = "Defaults restored"
                }
                else {
                    output = "Restore cancelled"
                }
                
                completion(response: output)
            }
            
            return
        }
        else {
            let action = command.elements[1]
            let term = command.elements[2]
            var output: String?
            
            if action == "read" {
                if let value = Setting.defaultForSettingType(SettingType(rawValue: term)) {
                    output = value.description
                }
                else {
                    output = "Invalid default"
                }
            }
            else if action == "write" {
                if term == "time" {
                    let stringValue = NSString(string: command.elements[3])
                    let value = stringValue.boolValue
                    Setting.setDefaultForSettingType(value, type: SettingType(rawValue: term))
                }
            }
            
            completion(response: output)
        }
    }
    
    func help() -> String {
        return ""
    }
}

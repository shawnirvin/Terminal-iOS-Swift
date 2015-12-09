//
//  TerminalView.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/7/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

enum InputType {
    case Normal, Secure
}

class TerminalView: UITextView, UITextFieldDelegate, UITextViewDelegate {
    
    private let textField = UITextField(frame: CGRectMake(0,0,0,0))
    private var retrievingUserInput = false {
        didSet {
            if self.retrievingUserInput {
                self.cursorTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "blinkCursor:", userInfo: nil, repeats: true)
            }
            else {
                self.cursorTimer?.invalidate()
                self.cursorVisible = false
                self.typing = false
            }
        }
    }
    
    var inputType = InputType.Normal
    var inputString = "" {
        didSet {
            if (inputType != .Secure) {
                self.text = self.text.substringToIndex(self.currentLineStartIndex) + self.inputString
                
                if self.typing {
                    self.text = self.text + self.cursor
                }
            }
            
            var endIndex = self.text.endIndex
            let lastChar = self.text.characters.last
            
            if lastChar == self.cursor.characters.last {
               endIndex = endIndex.advancedBy(-1)
            }
            
            self.currentLineEndIndex = endIndex
        }
    }
    var completionBlock: ((input:String) -> Void)?
    
    private let cursor = "_"
    
    private var cursorTimer: NSTimer?
    private var typingTimer: NSTimer?
    private var currentLineStartIndex: String.Index!
    private var currentLineEndIndex: String.Index!
    private var cursorVisible = false {
        didSet {
            if oldValue != self.cursorVisible {
                if self.cursorVisible {
                    self.text = self.text + self.cursor
                }
                else {
                    self.text = self.text.substringToIndex(self.currentLineEndIndex)
                }
            }
        }
    }
    private var typing = false {
        didSet {
            if typing == true {
                if self.typingTimer?.valid == true {
                    self.typingTimer?.invalidate()
                }
                
                self.typingTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "endTyping:", userInfo: nil, repeats: false)
                
                self.cursorVisible = true
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        addTextField()
        self.delegate = self
        self.editable = false
        
        self.text = ""
        
        self.currentLineStartIndex = self.text.endIndex
        self.currentLineEndIndex = self.text.endIndex
    }
    
    private func addTextField() {
        self.textField.hidden = true
        self.textField.secureTextEntry = true
        self.textField.autocapitalizationType = .None
        self.textField.autocorrectionType = .No
        self.textField.spellCheckingType = .No
        self.textField.keyboardAppearance = .Dark
        self.textField.keyboardType = .Default
        self.textField.delegate = self
        
        self.addSubview(self.textField)
        self.textField.becomeFirstResponder()
    }
    
    func blinkCursor(timer: NSTimer) {
        if !self.typing {
            self.cursorVisible = !self.cursorVisible
        }
    }
    
    func endTyping(timer: NSTimer) {
        self.typing = false
    }
    
    func getInput(inputPrefix: String, inputType: InputType, completion: (input:String) -> Void) {
        self.retrievingUserInput = true
        self.completionBlock = completion
        
        var prefix = inputPrefix
        
        if self.text.characters.count > 0 {
            prefix = "\n" + inputPrefix
        }
        
        print(prefix)
        
        self.currentLineStartIndex = self.text.endIndex
        self.inputString = ""
    }
    
    func print(output: String) {
        let newText = self.text.substringToIndex(self.currentLineEndIndex) + output
        self.text = newText
        
        if self.cursorVisible {
            self.currentLineEndIndex = self.text.endIndex.advancedBy(-1)
        }
        else {
            self.currentLineEndIndex = self.text.endIndex
        }
    }
    
    func clear() {
        self.text = ""
        self.currentLineStartIndex = self.text.endIndex
        self.currentLineEndIndex = self.currentLineStartIndex
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (self.retrievingUserInput) {
            self.typing = true
            
            if string == "\n" {
                textField.text = ""
                
                if let completion = self.completionBlock {
                    self.retrievingUserInput = false
                    let response = self.inputString
                    completion(input: response)
                }
                
                return false
            }
            else {
                let startIndex = self.inputString.startIndex.advancedBy(range.location)
                let endIndex = self.inputString.startIndex.advancedBy(range.location + range.length)
                let stringRange = Range<String.Index>(start: startIndex, end: endIndex)
                
                self.inputString = self.inputString.stringByReplacingCharactersInRange(stringRange, withString: string)
                
                return true
            }
        }
        else {
            return false
        }
    }
}

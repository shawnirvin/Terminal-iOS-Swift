//
//  ViewController.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

class TerminalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var terminalTextView: UITextView!
    
    let lineStartChar = ":"
    let cursor = "_"
    var cursorTimer: NSTimer?
    var typingTimer: NSTimer?
    var currentLineStartIndex: String.Index!
    var cursorIndex: String.Index!
    var cursorVisible = true
    var typing = false {
        didSet {
            if typing == true {
                if self.typingTimer?.valid == true {
                    self.typingTimer?.invalidate()
                }
                
                self.typingTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "endTyping:", userInfo: nil, repeats: false)
                
                if (self.cursorVisible == false) {
                    self.terminalTextView.text = self.terminalTextView.text + self.cursor
                    self.cursorVisible = true
                }
            }
        }
    }
    static var currentProgram: Program = MainProgram()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.terminalTextView.text = TerminalViewController.currentProgram.name + self.lineStartChar + " " + self.cursor
        self.cursorIndex = self.terminalTextView.text.endIndex
        self.currentLineStartIndex = self.cursorIndex.advancedBy(-1)
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            let height = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height
            
            self.terminalTextView.frame.size.height = self.view.frame.size.height - height!
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.terminalTextView.frame.size.height = self.view.frame.size.height
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textField.becomeFirstResponder()
        
        self.cursorTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "blinkCursor:", userInfo: nil, repeats: true)
    }
    
    func blinkCursor(timer: NSTimer) {
        if !self.typing {
            if self.cursorVisible {
                self.terminalTextView.text = self.terminalTextView.text.substringToIndex(self.cursorIndex.advancedBy(-1))
                self.cursorVisible = false
            }
            else {
                self.terminalTextView.text = self.terminalTextView.text + self.cursor
                self.cursorVisible = true
            }
        }
    }
    
    func endTyping(timer: NSTimer) {
        self.typing = false
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.typing = true
        
        var endIndex = self.terminalTextView.text.endIndex.advancedBy(-1)
        
        if string == "\n" {
            let commandRange = Range<String.Index>(start: self.currentLineStartIndex, end: endIndex)
            let command = self.terminalTextView.text.substringWithRange(commandRange)
            
            if command == "clear" {
                self.terminalTextView.text = TerminalViewController.currentProgram.name + self.lineStartChar + " " + self.cursor
            }
            else {
                if let response = TerminalViewController.currentProgram.runCommand(command) {
                    self.terminalTextView.text = self.terminalTextView.text.substringToIndex(endIndex) + "\n\t" + response
                    endIndex = self.terminalTextView.text.endIndex
                }
                
                let newLineText = "\n" + TerminalViewController.currentProgram.name + self.lineStartChar + " " + self.cursor
                
                self.terminalTextView.text = self.terminalTextView.text.substringToIndex(endIndex) + newLineText
            }
            
            self.cursorIndex = self.terminalTextView.text.endIndex
            self.currentLineStartIndex = self.cursorIndex.advancedBy(-1)
            
            textField.text = ""
            
            return false
        }
        else {
            var terminalString = self.terminalTextView.text.substringWithRange(Range<String.Index>(start: self.currentLineStartIndex, end: endIndex));
            
            let newRange = Range(start: terminalString.startIndex.advancedBy(range.location), end: terminalString.startIndex.advancedBy(range.location+range.length))
            
            terminalString = terminalString.stringByReplacingCharactersInRange(newRange, withString: string)
            
            self.terminalTextView.text = self.terminalTextView.text.substringToIndex(self.currentLineStartIndex) + terminalString + self.cursor
            
            self.cursorIndex = self.terminalTextView.text.endIndex
            
            return true
        }
    }
    
}


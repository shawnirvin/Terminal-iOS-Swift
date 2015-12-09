//
//  ViewController.swift
//  Terminal
//
//  Created by Shawn Irvin on 11/25/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

class TerminalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var terminalTextView: TerminalView!
    
    let lineStartChar = ":"
    static var currentInstance: TerminalViewController!
    var currentProgram: Program = MainProgram()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TerminalViewController.currentInstance = self
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            let height = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height
            
            self.terminalTextView.frame.size.height = self.view.frame.size.height - height!
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.terminalTextView.frame.size.height = self.view.frame.size.height
        }
        
        getInput()
    }
    
    func getInput() {
        terminalTextView.getInput(self.currentProgram.name + self.lineStartChar + " ", inputType: .Normal) { userInput in
            self.currentProgram.runCommand(Command(rawInput: userInput)) { response in
                if let output = response {
                    self.terminalTextView.print("\n\t" + output)
                }
                
                self.getInput()
            }
        }
    }
}


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
    
    static var currentInstance: TerminalViewController!
    private let lineStartChar = ":"
    var currentProgram: Program = MainProgram()
    private lazy var dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateFormat = "HH:mm:ss"
        
        return df
    }()
    
    var currentTime: String {
        get {
            return self.dateFormatter.stringFromDate(NSDate())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.setDefaultsIfNotSet()
        
        TerminalViewController.currentInstance = self
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            let height = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height
            
            self.terminalTextView.frame.size.height = self.view.frame.size.height - height!
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.terminalTextView.frame.size.height = self.view.frame.size.height
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getInput()
    }
    
    func getInput() {
        var prefix = self.currentProgram.name + self.lineStartChar + " "
        
        if Setting.defaultForSettingType(.ShowTime) as! Bool {
            prefix = "[" + self.currentTime + "] " + prefix
        }
        
        terminalTextView.getInput(prefix, inputType: .Normal) { userInput in
            self.currentProgram.runCommand(Command(rawInput: userInput)) { response in
                if let output = response {
                    self.terminalTextView.print("\n\t" + output)
                }
                
                self.getInput()
            }
        }
    }
}


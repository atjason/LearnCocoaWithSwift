//
//  MainWindowController.swift
//  GeneratePassword
//
//  Created by Jason Zheng on 3/31/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var textField: NSTextField!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()        
    }
    
    @IBAction func generatePassword(sender: AnyObject?) {
        let passwordLength = 8
        
        let password = generateRandomString(passwordLength)
        
        textField.stringValue = password
    }    
}

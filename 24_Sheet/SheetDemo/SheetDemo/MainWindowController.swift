//
//  MainWindowController.swift
//  SheetDemo
//
//  Created by Jason Zheng on 4/19/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  @IBOutlet var textView: NSTextView!
  
  var addPersonWindowController: AddPersonWindowController?
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - Action
  
  @IBAction func addPerson(sender: NSButton) {
    if addPersonWindowController == nil {
      addPersonWindowController = AddPersonWindowController()
    }
    
    if let window = addPersonWindowController?.window {
      self.window?.beginSheet(window, completionHandler: addNewPerson)
    }
  }
  
  // MARK: - Helper
  
  func addNewPerson(response: NSModalResponse) {
    if response == NSModalResponseOK {
      if let description = addPersonWindowController?.person.description {
        if textView.string != nil {
          textView.string? += description + "\n"
        }
      }
    }
  }
}

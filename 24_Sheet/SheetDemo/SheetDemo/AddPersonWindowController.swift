//
//  AddPersonWindowController.swift
//  SheetDemo
//
//  Created by Jason Zheng on 4/19/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class AddPersonWindowController: NSWindowController {
  
  dynamic var name = ""
  dynamic var age = 0
  
  var person: Person {
    get {
      return Person(name: name, age: age)
    }
    
    set {
      name = newValue.name
      age = newValue.age
    }
  }

  override var windowNibName: String? {
    return "AddPersonWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
  }
  
  // MARK: - Action
  
  @IBAction func add(sender: NSButton) {
    // This is let binding value be updated.
    window?.endEditingFor(nil)
    dismissWindowWithResponse(NSModalResponseOK)
  }
  
  @IBAction func cancel(sender: NSButton) {
    dismissWindowWithResponse(NSModalResponseCancel)
  }
  
  // MARK: - Helper
  
  func dismissWindowWithResponse(response: Int) {
    if let window = window {
      window.sheetParent?.endSheet(window, returnCode: response)
    }
  }
}

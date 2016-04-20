//
//  MainWindowController.swift
//  NSPopUpButtonDemo
//
//  Created by Jason Zheng on 4/20/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  dynamic var personArray = [Person]()
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    
    personArray.append(Person(name: "Tom", age: 30))
    personArray.append(Person(name: "Jack", age: 29))
  }
}

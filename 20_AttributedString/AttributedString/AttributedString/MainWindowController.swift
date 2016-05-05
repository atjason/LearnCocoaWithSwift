//
//  MainWindowController.swift
//  AttributedString
//
//  Created by Jason Zheng on 5/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  @IBOutlet weak var button: NSButton!
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
}

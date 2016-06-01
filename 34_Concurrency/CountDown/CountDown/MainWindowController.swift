//
//  MainWindowController.swift
//  CountDown
//
//  Created by Jason Zheng on 6/2/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  dynamic var numString = ""
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - Action
  
  @IBAction func start(sender: NSButton!) {
    
  }
  
  @IBAction func stop(sender: NSButton!) {
    
  }
  
  // MARK: - Helper
  
  func startCountDown(num: Int) {
    
  }
  
  func stopCountDown() {
    
  }
}

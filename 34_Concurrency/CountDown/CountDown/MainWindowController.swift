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
  
  private var countDownQueue = NSOperationQueue()
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - Action
  
  @IBAction func start(sender: NSButton!) {
    window?.makeFirstResponder(nil)
    if let num = Int(numString) {
      startCountDown(num)
    }
  }
  
  @IBAction func stop(sender: NSButton!) {
    
  }
  
  // MARK: - Helper
  
  func startCountDown(num: Int) {
    var num = num
    countDownQueue.addOperationWithBlock { 
      while num > 0 {
        sleep(1)
        num -= 1
        NSOperationQueue.mainQueue().addOperationWithBlock({ 
          self.numString = "\(num)"
        })
      }
    }
  }
  
  func stopCountDown() {
    
  }
}

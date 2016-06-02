//
//  MainWindowController.swift
//  CountDown
//
//  Created by Jason Zheng on 6/2/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  dynamic var numString = "5"
  
  private var countDownQueue = NSOperationQueue()
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - Action
  
  @IBAction func start(sender: NSButton!) {
    window?.makeFirstResponder(nil)
    if let num = Int(numString) where num > 0 {
      startCountDown(num)
    }
  }
  
  @IBAction func stop(sender: NSButton!) {
    stopCountDown()
  }
  
  // MARK: - Helper
  
  func startCountDown(num: Int) {
    var num = num
    countDownQueue.addOperationWithBlock {
      while num > 0 {
        sleep(1)
        
        if self.countDownQueue.operations[0].cancelled {
          break
        }
        
        num -= 1
        NSOperationQueue.mainQueue().addOperationWithBlock({
          self.numString = "\(num)"
        })
      }
    }
  }
  
  func stopCountDown() {
    countDownQueue.cancelAllOperations()
  }
}

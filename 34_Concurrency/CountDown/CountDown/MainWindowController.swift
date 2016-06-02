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
  dynamic var isCountingDown = false
  
  private var countDownQueue = NSOperationQueue()
  private var countDownOperation: NSBlockOperation?
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - Action
  
  @IBAction func start(sender: NSButton!) {
    window?.makeFirstResponder(nil)
    if let num = Int(numString) where num > 0 {
      startCountDown(num)
      isCountingDown = true
    }
  }
  
  @IBAction func stop(sender: NSButton!) {
    stopCountDown()
    isCountingDown = false
  }
  
  // MARK: - Helper
  
  func startCountDown(num: Int) {
    var num = num
    
    countDownOperation = NSBlockOperation(block: { 
      while num > 0 {
        sleep(1)

        if self.countDownOperation!.cancelled {
          break
        }

        num -= 1
        NSOperationQueue.mainQueue().addOperationWithBlock({
          self.numString = "\(num)"
        })
      }

      if num == 0 {
        NSOperationQueue.mainQueue().addOperationWithBlock({
          self.isCountingDown = false
        })
      }
    })
    
    countDownQueue.addOperation(countDownOperation!)
  }
  
  func stopCountDown() {
    countDownQueue.cancelAllOperations()
  }
}

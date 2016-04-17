//
//  ViewController.swift
//  Ping
//
//  Created by Jason Zheng on 4/17/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  dynamic var domain = ""
  
  @IBOutlet weak var pingButton: NSButton!
  @IBOutlet var textView: NSTextView!
  
  let notificationCenter = NSNotificationCenter.defaultCenter()
  
  var task: NSTask?
  var fileHandle: NSFileHandle?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    domain = "toolinbox.net"
  }
  
  override func viewWillDisappear() {
    notificationCenter.removeObserver(self)
  }

  // MARK: - Action
  
  @IBAction func ping(sender: NSButton) {
    
    if sender.state == NSOnState {
      task = NSTask()
      task?.launchPath = "/sbin/ping"
      task?.arguments = ["-c4", domain]
      
      let pipe = NSPipe()
      task?.standardOutput = pipe
      fileHandle = pipe.fileHandleForReading
      
      notificationCenter.removeObserver(self)
      notificationCenter.addObserver(self,
        selector: #selector(ViewController.receiveDataReadyNotification(_:)),
        name: NSFileHandleReadCompletionNotification, object: fileHandle)
      notificationCenter.addObserver(self,
        selector: #selector(ViewController.receiveTerminateNotification(_:)),
        name: NSTaskDidTerminateNotification, object: task)
      
      task?.launch()
      
      clearString()
      fileHandle?.readInBackgroundAndNotify()
      
    } else {
      task?.interrupt()
    }
  }
  
  // MARK: - Notification
  
  func receiveDataReadyNotification(notification: NSNotification) {
    if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? NSData {
      if let string = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
        appendString(string)
      }
    }
    
    // Continue to read if fileHandle isn't nil.
    fileHandle?.readInBackgroundAndNotify()
  }
  
  func receiveTerminateNotification(notification: NSNotification) {
    task = nil
    fileHandle = nil
    
    pingButton.state = NSOffState
  }
  
  // MARK: - Helper
  
  func clearString() {
    if let textStorage = textView.textStorage {
      textStorage.replaceCharactersInRange(NSRange(0..<textStorage.length), withString: "")
    }
  }
  
  func appendString(string: String) {
    if let textStorage = textView.textStorage {
      textStorage.replaceCharactersInRange(NSRange(location: textStorage.length, length: 0), withString: string)
    }
  }
}


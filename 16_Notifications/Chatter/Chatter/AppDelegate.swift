//
//  AppDelegate.swift
//  Chatter
//
//  Created by Jason Zheng on 4/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var chatWindowControllers = [ChatWindowController]()
  
  // MARK: - lifecycle
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    NSValueTransformer.setValueTransformer(IsNotEmptyTransformer(), forName: "IsNotEmptyTransformer")
    addWindowController()
  }
  
  // MARK: - Actions
  
  @IBAction func addNewChatWindows(sender: NSObject) {
    addWindowController()
  }
  
  // MARK: - Helpers
  
  func addWindowController() {
    let chatWindowController = ChatWindowController()
    chatWindowController.showWindow(self)
    
    chatWindowControllers.append(chatWindowController)
  }
}


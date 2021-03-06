//
//  AppDelegate.swift
//  AttributedString
//
//  Created by Jason Zheng on 5/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var mainWindowController: MainWindowController?

  func applicationDidFinishLaunching(aNotification: NSNotification) {
      
    let mainWindowController = MainWindowController()
    mainWindowController.showWindow(self)
    
    self.mainWindowController = mainWindowController
  }
}


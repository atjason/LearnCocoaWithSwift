//
//  MainWindowController.swift
//  WindowOfFixedAspectRatio
//
//  Created by Jason Zheng on 4/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
    var correctSize = NSSize()
    
    correctSize.width = max(frameSize.width, frameSize.height * 2)
    correctSize.height = max(frameSize.height, frameSize.width / 2)
    
    return correctSize
  }
}
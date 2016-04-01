//
//  MainWindowController.swift
//  RGBWell
//
//  Created by Jason Zheng on 3/31/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  dynamic var red = 0.0 {
    didSet {
      updateColor()
    }
  }
  dynamic var green = 0.0
  dynamic var blue = 0.0
  dynamic var alpha = 0.0
  
  private let keyPathArray = ["green", "blue", "alpha"]
  
  dynamic var color = NSColor.blackColor()
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    
    red = 0.4
    green = 0.6
    blue = 0.8
    alpha = 1.0
    
    updateColor()
    
    for keyPath in keyPathArray {
      addObserver(self, forKeyPath: keyPath,
                  options: NSKeyValueObservingOptions.Old, context: nil)
    }
  }
  
  override func observeValueForKeyPath(keyPath: String?,
      ofObject object: AnyObject?,
      change: [String : AnyObject]?,
      context: UnsafeMutablePointer<Void>) {
    
    if let path = keyPath {
      if keyPathArray.contains(path) {
        updateColor()
      }
    }
  }
  
  func updateColor() {
    color = NSColor(calibratedRed: CGFloat(red),
                              green: CGFloat(green),
                              blue: CGFloat(blue),
                              alpha: CGFloat(alpha))
  }
}

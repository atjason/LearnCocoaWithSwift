//
//  MainWindowController.swift
//  MirrorChatter
//
//  Created by Jason Zheng on 4/13/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

  override func windowDidLoad() {
    super.windowDidLoad()
    
    window?.setFrame(NSRect.init(x: 0, y: 0, width: 400, height: 200), display: true)
    window?.center()
  }
}

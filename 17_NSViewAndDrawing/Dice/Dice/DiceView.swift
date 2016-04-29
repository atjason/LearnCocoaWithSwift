//
//  DiceView.swift
//  Dice
//
//  Created by Jason Zheng on 4/30/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class DiceView: NSView {
  override func drawRect(dirtyRect: NSRect) {
    NSColor.lightGrayColor().set()
    NSBezierPath.fillRect(bounds)
  }
}

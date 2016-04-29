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
    
    NSColor.greenColor().set()
    let path = NSBezierPath()
    path.moveToPoint(NSPoint(x: 0, y: 0))
    path.lineToPoint(NSPoint(x: bounds.width, y: bounds.height))
    path.stroke()
  }
}

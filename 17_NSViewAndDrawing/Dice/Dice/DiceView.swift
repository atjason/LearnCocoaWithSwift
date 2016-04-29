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
  
  func metricsForSize(size: NSSize) -> (edgeLength: CGFloat, dieFrame: NSRect) {
    let edgeLength = min(size.width, size.height)
    
    let padding = edgeLength / 10.0
    let drawingBounds = NSRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
    let dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
    
    return (edgeLength, dieFrame)
  }
}

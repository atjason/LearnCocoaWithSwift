//
//  DiceView.swift
//  Dice
//
//  Created by Jason Zheng on 4/30/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class DiceView: NSView {
  
  var intValue: Int? = 3 {
    didSet {
      needsDisplay = true
    }
  }
  
  var pressed: Bool = false {
    didSet {
      needsDisplay = true
    }
  }
  
  override func drawRect(dirtyRect: NSRect) {
    NSColor.lightGrayColor().set()
    NSBezierPath.fillRect(bounds)
    
    drawDieWithSize(bounds.size)
  }
  
  func drawDieWithSize(size: NSSize) {
    if let intValue = intValue {
      let (edgeLength, dieFrame) = metricsForSize(size)
      
      // Rounded border
      NSGraphicsContext.saveGraphicsState()
      
      let shadow = NSShadow()
      shadow.shadowOffset = NSSize(width: 0, height: -1)
      shadow.shadowBlurRadius = pressed ? edgeLength / 100.0 : edgeLength / 20.0
      shadow.set()
      
      let cornerRadius = edgeLength / 5.0
      NSColor.whiteColor().set()
      NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
      
      NSGraphicsContext.restoreGraphicsState()
      
      // Dot      
      
      let dotRadius = edgeLength / 12.0
      let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
      
      NSColor.blackColor().set()
      
      // Nested function to make drawing dots cleaner.
      func drawDot(u: CGFloat, _ v: CGFloat) {
        let dotOrigin = NSPoint(x: dotFrame.minX + u * dotFrame.width,
                                y: dotFrame.minY + v * dotFrame.height)
        let dotRect = NSRect(origin: dotOrigin, size: NSSize(width: 0, height: 0))
          .insetBy(dx: -dotRadius, dy: -dotRadius)
        NSBezierPath(ovalInRect: dotRect).fill()
      }
      
      // If intValue is in range...
      if (1...6).indexOf(intValue) != nil {
        // Draw the dots:
        if [1, 3, 5].indexOf(intValue) != nil {
          drawDot(0.5, 0.5) // Center dot
        }
        if (2...6).indexOf(intValue) != nil {
          drawDot(0, 1) // Upper left
          drawDot(1, 0) // Lower right
        }
        if (4...6).indexOf(intValue) != nil {
          drawDot(1, 1) // Upper right
          drawDot(0, 0) // Lower left
        }
        if intValue == 6 {
          drawDot(0, 0.5) // Mid left/right
          drawDot(1, 0.5)
        }
      }
    }
  }

  func metricsForSize(size: NSSize) -> (edgeLength: CGFloat, dieFrame: NSRect) {
    let edgeLength = min(size.width, size.height)
    
    let padding = edgeLength / 10.0
    let drawingBounds = NSRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
    var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
    if pressed {
      dieFrame = dieFrame.offsetBy(dx: 0, dy: -edgeLength / 40)
    }
    
    return (edgeLength, dieFrame)
  }
  
  // MARK: - Helper
  
  func randomize() {
    intValue = Int(arc4random_uniform(5)) + 1
  }
  
  // MARK: - Mouse Events
  
  override func mouseDown(theEvent: NSEvent) {
    Swift.print("Mouse down")
    
    let dieFrame = metricsForSize(bounds.size).dieFrame
    let pointInView = convertPoint(theEvent.locationInWindow, fromView: nil)
    
    pressed = dieFrame.contains(pointInView)
  }
  
  override func mouseUp(theEvent: NSEvent) {
    Swift.print("Mouse up. Clicked: \(theEvent.clickCount)")
    
    if theEvent.clickCount == 2 {
      randomize()
    }
    
    pressed = false
  }
  
  override func mouseDragged(theEvent: NSEvent) {
    Swift.print("Mouse dragged. Mouse location: \(theEvent.locationInWindow)")
  }
  
  // MARK: - First Responder
  
  override var acceptsFirstResponder: Bool {
    return true
  }
  
  override func becomeFirstResponder() -> Bool {
    return true
  }
  
  override func resignFirstResponder() -> Bool {
    return true
  }
  
  override var focusRingMaskBounds: NSRect {
    return bounds
  }

  override func drawFocusRingMask() {
    NSBezierPath.fillRect(bounds)
  }
  
  // MARK: - Keyboard Events
  
  override func keyDown(theEvent: NSEvent) {
    interpretKeyEvents([theEvent])
  }
  
  override func insertText(insertString: AnyObject) {
    if let str = insertString as? String {
      if let num = Int.init(str) {
        if (1...6).indexOf(num) != nil {
          intValue = num
        }
      }
    }
  }
  
  override func insertTab(sender: AnyObject?) {
    window?.selectNextKeyView(sender)
  }
  
  override func insertBacktab(sender: AnyObject?) {
    window?.selectPreviousKeyView(sender)
  }
}

//
//  DiceView.swift
//  Dice
//
//  Created by Jason Zheng on 4/30/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class DiceView: NSView, NSDraggingSource {
  
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
  
  var highlighted: Bool = false {
    didSet {
      needsDisplay = true
    }
  }
  
  var highlightForDrag: Bool = false {
    didSet {
      needsDisplay = true
    }
  }
  
  var mouseDownEvent: NSEvent?
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    commonInit()
  }
  
  func commonInit() {
    self.registerForDraggedTypes([NSPasteboardTypeString])
  }
  
  override func drawRect(dirtyRect: NSRect) {
    let backgroundColor = highlighted ? NSColor.grayColor() : NSColor.lightGrayColor()
    backgroundColor.set()
    NSBezierPath.fillRect(bounds)
    
    if highlightForDrag {
      let gradient = NSGradient(startingColor: NSColor.whiteColor(), endingColor: backgroundColor)
      gradient?.drawInRect(bounds, relativeCenterPosition: NSPoint())
      
    } else {
      drawDieWithSize(bounds.size)
    }
  }
  
  override func viewDidMoveToWindow() {
    window?.acceptsMouseMovedEvents = true
    
    let options: NSTrackingAreaOptions = (NSTrackingAreaOptions.MouseEnteredAndExited)
      .union(NSTrackingAreaOptions.ActiveAlways)
      .union(NSTrackingAreaOptions.InVisibleRect)
    let trackingArea = NSTrackingArea(rect: NSRect(), options: options, owner: self, userInfo: nil)
    addTrackingArea(trackingArea)
  }
  
  override func resetCursorRects() {
    let cursor = NSCursor.pointingHandCursor()
    addCursorRect(bounds, cursor: cursor)
    cursor.setOnMouseEntered(true)
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
      } else {
        let font = NSFont.systemFontOfSize(edgeLength / 1.5)
        let color = NSColor.blackColor()
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .Center
        let attrs = [
          NSFontAttributeName: font,
          NSForegroundColorAttributeName: color,
          NSParagraphStyleAttributeName: paragraphStyle,
        ]
        let string = String(intValue) as NSString
        string.drawCenteredInRect(dieFrame, attrs: attrs)
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
  
  // MARK: - Actions
  
  @IBAction func saveAsPDF(sender: AnyObject!) {
    let savePanel = NSSavePanel()
    savePanel.allowedFileTypes = ["pdf"]
    savePanel.beginSheetModalForWindow(window!, completionHandler: {
      [unowned savePanel] (result) in
      
      if result == NSModalResponseOK {
        let data = self.dataWithPDFInsideRect(self.bounds)
        
        do {
          try data.writeToURL(savePanel.URL!, options: NSDataWritingOptions.DataWritingAtomic)
          
        } catch {
          let alert = NSAlert(error: error as NSError)
          alert.runModal()
        }
      }
      })
  }
  
  // MARK: - Helper
  
  func randomize() {
    intValue = Int(arc4random_uniform(5)) + 1
  }
  
  // MARK: - Mouse Events
  
  override func mouseDown(theEvent: NSEvent) {
    mouseDownEvent = theEvent
    
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
    let downPoint = mouseDownEvent!.locationInWindow
    let dragPoint = theEvent.locationInWindow
    let distanceDragged = hypot(dragPoint.x - downPoint.x, dragPoint.y - downPoint.y)
    guard distanceDragged >= 6 else { return }
    
    highlightForDrag = true
    
    if let intValue = intValue {
      let imageSize = bounds.size
      let image = NSImage(size: imageSize, flipped: false) { imageBounds in
        self.drawDieWithSize(imageBounds.size)
        return true
      }
      
      let draggingFrameOrigin = convertPoint(downPoint, fromView: nil)
      let draggingFrame = NSRect(origin: draggingFrameOrigin, size: imageSize)
        .offsetBy(dx: -imageSize.width / 2.0, dy: -imageSize.height / 2.0)
      
      let item = NSDraggingItem(pasteboardWriter: String(intValue))
      item.draggingFrame = draggingFrame
      item.imageComponentsProvider = {
        let component = NSDraggingImageComponent(key: NSDraggingImageComponentIconKey)
        component.contents = image
        component.frame = NSRect(origin: NSPoint(), size: imageSize)
        
        return [component]
      }
      
      beginDraggingSessionWithItems([item], event: mouseDownEvent!, source: self)
    }
  }
  
  override func mouseEntered(theEvent: NSEvent) {
    highlighted = true
  }
  
  override func mouseExited(theEvent: NSEvent) {
    highlighted = false
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
        if (0...9).indexOf(num) != nil {
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
  
  // MARK: - Pasteboard
  
  func writeToPasteboard(pasteboard: NSPasteboard) {
    if let intValue = intValue {
      pasteboard.clearContents()
      pasteboard.writeObjects([String(intValue)])
    }
  }
  
  func readFromPasteboard(pasteboard: NSPasteboard) -> Bool {
    if let string = pasteboard.stringForType(NSPasteboardTypeString) {
      if let int = Int(string) {
        intValue = int
        return true
      }
    }
    return false
  }
  
  @IBAction func cut(sender: AnyObject?) {
    writeToPasteboard(NSPasteboard.generalPasteboard())
    intValue = nil
  }
  
  @IBAction func copy(sender: AnyObject?) {
    writeToPasteboard(NSPasteboard.generalPasteboard())
  }
  
  @IBAction func paste(sender: AnyObject?) {
    readFromPasteboard(NSPasteboard.generalPasteboard())
  }
  
  // MARK: - Menu Item
  
  override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
    switch menuItem.action {
    case #selector(DiceView.cut(_:)), #selector(DiceView.copy(_:)):
      return intValue != nil
      
    default:
      return super.validateMenuItem(menuItem)
    }
  }
  
  // MARK: - NSDraggingSource
  
  func draggingSession(session: NSDraggingSession, sourceOperationMaskForDraggingContext context: NSDraggingContext) -> NSDragOperation {
    return NSDragOperation.Copy.union(.Delete)
  }
  
  func draggingSession(session: NSDraggingSession, endedAtPoint screenPoint: NSPoint, operation: NSDragOperation) {
    if operation == .Delete {
      intValue = nil
    }
    
    pressed = false
    highlightForDrag = false
  }
}

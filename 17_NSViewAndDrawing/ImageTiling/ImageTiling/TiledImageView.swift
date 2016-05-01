//
//  TiledImageView.swift
//  ImageTiling
//
//  Created by Jason Zheng on 5/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

@IBDesignable class TiledImageView: NSView {
  @IBInspectable var image: NSImage?
  let rowCount = 5
  let columnCount = 4
  
  override var intrinsicContentSize: NSSize {
    let furthestFrame = frameForImageAtLogicalX(columnCount - 1, y: rowCount - 1)
    return NSSize(width: furthestFrame.maxX, height: furthestFrame.maxY)
  }
  
  override func drawRect(dirtyRect: NSRect) {
    if let image = image {
      for x in (0..<rowCount) {
        for y in (0..<columnCount) {
          let frame = frameForImageAtLogicalX(x, y: y)
          image.drawInRect(frame)
        }
      }
    }
  }
  
  // MARK: - Drawing
  
  func frameForImageAtLogicalX(logicalX: Int, y logicalY: Int) -> NSRect {
    let spacing = 10
    let width = 100
    let height = 100
    let x = (spacing + width) * logicalX
    let y = (spacing + height) * logicalY
    return NSRect(x: x, y: y, width: width, height: height)
  }
}


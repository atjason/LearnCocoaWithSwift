//
//  NSStringEx.swift
//  Dice
//
//  Created by Jason Zheng on 5/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

extension NSString {
  func drawCenteredInRect(rect: NSRect, attrs: [String: AnyObject]!) {
    let stringSize = sizeWithAttributes(attrs)
    
    var point = NSPoint()
    point.x = rect.origin.x + (rect.width - stringSize.width) / 2.0
    point.y = rect.origin.y + (rect.height - stringSize.height) / 2.0
    
    drawAtPoint(point, withAttributes: attrs)
  }
}

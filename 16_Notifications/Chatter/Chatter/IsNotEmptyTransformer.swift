//
//  IsNotEmptyTransformer.swift
//  Chatter
//
//  Created by Jason Zheng on 4/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

class IsNotEmptyTransformer: NSValueTransformer {
  class func transformedValueClass(value: AnyObject?) -> AnyObject? {
    return IsNotEmptyTransformer.self
  }
  
  class override func allowsReverseTransformation () -> Bool {
    return false
  }
  
  class func transformedValue(value: AnyObject?) -> AnyObject? {
    
    if let string = value as? String {
      return !string.isEmpty
    }
    
    return false
  }
}

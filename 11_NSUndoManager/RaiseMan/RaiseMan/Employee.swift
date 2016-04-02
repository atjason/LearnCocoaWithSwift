//
//  Employee.swift
//  RaiseMan
//
//  Created by Jason Zheng on 4/2/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

class Employee: NSObject {
  var name: String? = "New Employee"
  var raise: Double = 0.05
  
  override init() {}
  
  init(name: String?, raise: Double) {
    self.name = name
    self.raise = raise
  }
  
  override func validateValue(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>,
                              forKey inKey: String) throws {
    
    if inKey == "raise" && ioValue.memory == nil {
      let domain = "UserInputValidationErrorDomain"
      let code = 0
      let userInfo = [NSLocalizedDescriptionKey: "An employee's raise must be a number.",
                      NSLocalizedRecoverySuggestionErrorKey: "Please provide a valid value."]
      throw NSError(domain: domain, code: code, userInfo: userInfo)
    }
  }
}

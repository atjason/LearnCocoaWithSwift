//
//  Employee.swift
//  RaiseMan
//
//  Created by Jason Zheng on 4/2/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding {
  
  private static let keyName = "name"
  private static let keyRaise = "raise"
  
  private static let defaultName = "New Employee"
  private static let defaultRaise = 0.05
  
  var name: String? = defaultName
  var raise: Double = defaultRaise
  
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
  
  // MARK: - NSCoding
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey(Employee.keyName) as? String
    raise = aDecoder.decodeDoubleForKey(Employee.keyRaise)
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: Employee.keyName)
    aCoder.encodeDouble(raise, forKey: Employee.keyRaise)
  }
}

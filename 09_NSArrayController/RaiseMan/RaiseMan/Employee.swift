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
}

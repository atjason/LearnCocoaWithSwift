//
//  EmployeeArrayController.swift
//  RaiseMan
//
//  Created by Jason Zheng on 4/3/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class EmployeeArrayController: NSArrayController {
  override func newObject() -> AnyObject {
    let object = super.newObject()
    
    object.setValue("New Employee", forKey: "name")
    object.setValue(0.05, forKey: "raise")
    
    return object
  }
}

//
//  CarArrayController.swift
//  CarLot
//
//  Created by Jason Zheng on 4/3/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {
  override func newObject() -> AnyObject {
    let object = super.newObject()
    
    object.setValue("Car's name", forKey: "makeModel")
    object.setValue(NSDate(), forKey: "datePurchased")
    object.setValue(2, forKey: "condition")
    
    return object
  }
}

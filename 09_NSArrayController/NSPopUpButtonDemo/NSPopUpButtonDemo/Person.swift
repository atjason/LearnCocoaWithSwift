//
//  Person.swift
//  NSPopUpButtonDemo
//
//  Created by Jason Zheng on 4/20/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

class Person: NSObject {
  var name = ""
  var age = 0
  
  override init() {
    super.init()
  }
  
  init(name: String, age: Int) {
    super.init()
    
    self.name = name
    self.age = age
  }
}

//
//  Person.swift
//  SheetDemo
//
//  Created by Jason Zheng on 4/19/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

struct Person: CustomStringConvertible {
  var name = ""
  var age = 0
  
  var description: String {
    return "Name: \(name), age: \(age)"
  }
}

//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Jason Zheng on 4/15/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  dynamic var question = ""  
  dynamic var answer = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()

    question = "Q: What's the time now?"
    answer = "A: It's 5:20 am."
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }
}


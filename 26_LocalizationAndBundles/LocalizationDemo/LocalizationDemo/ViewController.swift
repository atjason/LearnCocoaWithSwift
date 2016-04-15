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

    setLabelStrings()
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.)
    }
  }
  
  // MARK: - Helper
  
  func setLabelStrings() {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .NoStyle
    dateFormatter.timeStyle = .ShortStyle
    let dateString = dateFormatter.stringFromDate(NSDate())
    
    question = NSLocalizedString("Q: What's the time now?", comment: "Question")
    answer = String(format: NSLocalizedString("A: It's %@.", comment: "Answer"), dateString)
  }
}


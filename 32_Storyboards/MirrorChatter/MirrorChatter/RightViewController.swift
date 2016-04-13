//
//  RightViewController.swift
//  MirrorChatter
//
//  Created by Jason Zheng on 4/13/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class RightViewController: NSViewController {
  
  dynamic var content = ""
  @IBOutlet weak var textField: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setViewContent(content: String) {
    self.content = content
  }
}
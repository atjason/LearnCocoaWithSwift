//
//  LeftViewController.swift
//  MirrorChatter
//
//  Created by Jason Zheng on 4/13/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class LeftViewController: NSViewController, NSTextFieldDelegate {

  dynamic var content = ""
  weak var delegate: LeftViewControllerDelegate?
  @IBOutlet weak var textField: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setViewContent(content: String) {
    self.content = content
  }
  
  // MARK: - NSTextFieldDelegate
  override func controlTextDidChange(obj: NSNotification) {
    // FIXME: why content didn't change at this time?
    delegate?.leftViewContentChanged(self, content: textField.stringValue)
  }
}

protocol LeftViewControllerDelegate: class {
  func leftViewContentChanged(viewController: LeftViewController?, content: String)
}

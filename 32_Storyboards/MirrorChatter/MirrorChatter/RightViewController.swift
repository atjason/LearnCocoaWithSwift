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
  weak var delegate: RightViewControllerDelegate?
  @IBOutlet weak var textField: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setViewContent(content: String) {
    self.content = content
  }
  
  // MARK: - NSTextFieldDelegate
  override func controlTextDidChange(obj: NSNotification) {
    delegate?.rightViewContentChanged(self, content: textField.stringValue)
  }
}

protocol RightViewControllerDelegate: class {
  func rightViewContentChanged(viewController: RightViewController?, content: String)
}

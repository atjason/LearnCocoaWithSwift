//
//  ViewController.swift
//  Ping
//
//  Created by Jason Zheng on 4/17/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet var textView: NSTextView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Action
  
  @IBAction func ping(sender: NSButton) {
    
    if let textStorage = textView.textStorage {
      textStorage.replaceCharactersInRange(NSRange(0..<textStorage.length), withString: "Hello World!")
    }
  
  }
}


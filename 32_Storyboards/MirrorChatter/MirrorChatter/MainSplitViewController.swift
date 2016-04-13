//
//  MainSplitViewController.swift
//  MirrorChatter
//
//  Created by Jason Zheng on 4/13/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, LeftViewControllerDelegate {
  
  weak var leftViewController: LeftViewController!
  weak var rightViewController: RightViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    leftViewController = splitViewItems[0].viewController as? LeftViewController
    rightViewController = splitViewItems[1].viewController as? RightViewController
    
    leftViewController.delegate = self
  }
  
  // MARK: - LeftViewControllerDelegate
  
  func leftViewContentChanged(viewController: LeftViewController?, content: String) {
    rightViewController.setViewContent(content)
  }
}

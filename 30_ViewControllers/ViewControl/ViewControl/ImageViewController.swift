//
//  ImageViewController.swift
//  ViewControl
//
//  Created by Jason Zheng on 4/20/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {
  
  dynamic var image: NSImage?
  @IBOutlet weak var imageView: NSImageView!
  
  override var nibName: String? {
    return "ImageViewController"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

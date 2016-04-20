//
//  AppDelegate.swift
//  ViewControl
//
//  Created by Jason Zheng on 4/20/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var window: NSWindow?
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    
    let imageViewControllerA = ImageViewController()
    imageViewControllerA.title = "Flow"
    // Note: Can't access imageView! at this time, as the view hasn't been loaded, 
    //       this outlet hasn't link with the real view, thus it's nil.
    // imageViewControllerA.imageView.image = NSImage(imageLiteral: NSImageNameFlowViewTemplate)
    // So, another way is to directly set the image, and then bind this image to imageView's value (i.e., image)
    imageViewControllerA.image = NSImage(imageLiteral: NSImageNameFlowViewTemplate)
    
    let imageViewControllerB = ImageViewController()
    imageViewControllerB.title = "Column"
    imageViewControllerB.image = NSImage(imageLiteral: NSImageNameColumnViewTemplate)
    
    let tabViewController = NSTabViewController()
    tabViewController.addChildViewController(imageViewControllerA)
    tabViewController.addChildViewController(imageViewControllerB)
    
    let window = NSWindow(contentViewController: tabViewController)
    window.makeKeyAndOrderFront(self)
    self.window = window
  }
}


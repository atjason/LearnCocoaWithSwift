//
//  MainWindowController.swift
//  RGBWell
//
//  Created by Jason Zheng on 3/31/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  var red = 0.0
  var green = 0.0
  var blue = 0.0
  var alpha = 0.0
  
  @IBOutlet weak var colorWell: NSColorWell!
  
  @IBOutlet weak var redSlider: NSSlider!
  @IBOutlet weak var greenSlider: NSSlider!
  @IBOutlet weak var blueSlider: NSSlider!
  @IBOutlet weak var alphaSlider: NSSlider!
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    
    red = 0.2
    green = 0.4
    blue = 0.8
    alpha = 1.0
    
    redSlider.doubleValue = red
    greenSlider.doubleValue = green
    blueSlider.doubleValue = blue
    alphaSlider.doubleValue = alpha
    
    updateColor()
  }
  
  func updateColor() {
    colorWell.color = NSColor(calibratedRed: CGFloat(red),
                              green: CGFloat(green),
                              blue: CGFloat(blue),
                              alpha: CGFloat(alpha))
  }
  
  @IBAction func adjustRed(sender: NSSlider) {
    red = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustGreen(sender: NSSlider) {
    green = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustBlue(sender: NSSlider) {
    blue = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustAlpha(sender: NSSlider) {
    alpha = sender.doubleValue
    updateColor()
  }
}

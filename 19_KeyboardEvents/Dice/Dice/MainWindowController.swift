//
//  MainWindowController.swift
//  Dice
//
//  Created by Jason Zheng on 4/30/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  @IBOutlet weak var diceA: DiceView!
  @IBOutlet weak var diceB: DiceView!
  @IBOutlet weak var diceC: DiceView!
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    // Set tab order
    diceA.nextKeyView = diceB
    diceB.nextKeyView = diceC
    diceC.nextKeyView = diceA
  }
}

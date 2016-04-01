//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Jason Zheng on 4/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,
    NSSpeechSynthesizerDelegate, NSWindowDelegate {
  
  @IBOutlet weak var textField: NSTextField!
  @IBOutlet weak var speakButton: NSButton!
  @IBOutlet weak var stopButton: NSButton!
  
  var isSpeaking = false {
    didSet {
      updateButtonStatus()
    }
  }
  
  let speaker = NSSpeechSynthesizer()
  
  func updateButtonStatus() {
    if isSpeaking {
      speakButton.enabled = false
      stopButton.enabled = true
      
    } else {
      speakButton.enabled = true
      stopButton.enabled = false
    }
  }
  
  // MARK: - NSWindowController
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

  override func windowDidLoad() {
    updateButtonStatus()
    
    speaker.delegate = self
  }
  
  // MARK: - Action
  
  @IBAction func speak(sender: NSButton) {
    let stringToBeSpoken = textField.stringValue
    
    if !stringToBeSpoken.isEmpty {
      speaker.startSpeakingString(stringToBeSpoken)
      
      isSpeaking = true
    }
  }
  
  @IBAction func stop(sender: NSButton) {
    speaker.stopSpeaking()
  }
  
  // MARK: - NSSpeechSynthesizerDelegate
  
  func speechSynthesizer(sender: NSSpeechSynthesizer,
                         didFinishSpeaking finishedSpeaking: Bool) {
    isSpeaking = false
  }
  
  // MARK: - NSWindowDelegate
  
  func windowShouldClose(sender: AnyObject) -> Bool {
    return !isSpeaking
  }
}

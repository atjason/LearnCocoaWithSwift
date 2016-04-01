//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Jason Zheng on 4/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,
    NSSpeechSynthesizerDelegate, NSWindowDelegate,
    NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var textField: NSTextField!
  @IBOutlet weak var speakButton: NSButton!
  @IBOutlet weak var stopButton: NSButton!
  
  @IBOutlet weak var tableView: NSTableView!
  
  var isSpeaking = false {
    didSet {
      updateButtonStatus()
    }
  }
  
  let speaker = NSSpeechSynthesizer()
  let voices = NSSpeechSynthesizer.availableVoices()
  
  func updateButtonStatus() {
    if isSpeaking {
      speakButton.enabled = false
      stopButton.enabled = true
      
    } else {
      speakButton.enabled = true
      stopButton.enabled = false
    }
  }
  
  func getVoiceNameBy(idendifier: String) -> String? {
    
    let attritutes = NSSpeechSynthesizer.attributesForVoice(idendifier)
    
    return attritutes[NSVoiceName] as? String
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - NSWindowController
  
  override func windowDidLoad() {
    updateButtonStatus()
    
    speaker.delegate = self
    
    // Select system default voice
    if let index = voices.indexOf(NSSpeechSynthesizer.defaultVoice()) {
      tableView.selectRowIndexes(NSIndexSet(index: index),
                                 byExtendingSelection: false)
      tableView.scrollRowToVisible(index)
    }
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
  
  // MARK: - NSTableViewDataSource
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return voices.count
  }
  
  func tableView(tableView: NSTableView,
                 objectValueForTableColumn tableColumn: NSTableColumn?,
                 row: Int) -> AnyObject? {
    
    if row >= 0 && row < voices.count {
      return getVoiceNameBy(voices[row])
    }
    
    return nil
  }
  
  // MARK: - NSTableViewDelegate
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    let index = tableView.selectedRow
    
    if index == -1 {
      speaker.setVoice(nil)
      
    } else if index >= 0 && index < voices.count {
      speaker.setVoice(voices[index])
    }
  }
}

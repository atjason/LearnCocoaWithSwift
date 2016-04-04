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
  
  private let preferenceManager = PreferenceManager()
  
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
  
  func loadSpeakTextAndVoice() {
    textField.stringValue = preferenceManager.speakText ??
      preferenceManager.defaultSpeakText
    
    let voice = preferenceManager.speakVoice ??
      preferenceManager.defaultSpeakVoice
    
    if let index = voices.indexOf(voice) {
      tableView.selectRowIndexes(NSIndexSet(index: index),
                                 byExtendingSelection: false)
      tableView.scrollRowToVisible(index)
    }
  }
  
  // MARK: - NSWindowController
  
  override func windowDidLoad() {
    speaker.delegate = self
    
    updateButtonStatus()
    
    loadSpeakTextAndVoice()
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
  
  @IBAction func reset(sender: NSButton) {
    preferenceManager.resetFactoryDefaults()
    
    loadSpeakTextAndVoice()
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
  
  func windowWillClose(notification: NSNotification) {
    preferenceManager.speakText = textField.stringValue
    
    let row = tableView.selectedRow
    if row >= 0 && row < voices.count {
      preferenceManager.speakVoice = voices[row]
    } else {
      preferenceManager.speakVoice = preferenceManager.defaultSpeakVoice
    }
    
    // Write preference immediately as it's about to quit.
    preferenceManager.synchronize()
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

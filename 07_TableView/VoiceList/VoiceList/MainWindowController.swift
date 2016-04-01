//
//  MainWindowController.swift
//  VoiceList
//
//  Created by Jason Zheng on 4/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate,
    NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var voiceLabel: NSTextField!
  @IBOutlet weak var voiceTableView: NSTableView!
  
  let emptyVoiceLabelName = "None"
  
  let voices = NSSpeechSynthesizer.availableVoices()
  
  func getVoiceNameBy(identifier: String) -> String? {
    let attributes = NSSpeechSynthesizer.attributesForVoice(identifier)
    
    return attributes[NSVoiceName] as? String
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  // MARK: - NSWindowDelegate
  
  override func windowDidLoad() {
    let defaultVoice = NSSpeechSynthesizer.defaultVoice()
    
    if let index = voices.indexOf(defaultVoice) {
      voiceTableView.selectRowIndexes(NSIndexSet(index: index),
                                      byExtendingSelection: false)
      voiceTableView.scrollRowToVisible(index)
    }
  }
  
  // MARK: - NSTableViewDataSource
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return voices.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    
    if row >= 0 && row < voices.count {
      return getVoiceNameBy(voices[row])
    }
    
    return nil
  }
  
  // MARK: - NSTableViewDelegate
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    let index = voiceTableView.selectedRow
    
    if index >= 0 && index < voices.count {
      voiceLabel.stringValue = getVoiceNameBy(voices[index]) ?? emptyVoiceLabelName
    } else {
      voiceLabel.stringValue = emptyVoiceLabelName
    }
  }
}

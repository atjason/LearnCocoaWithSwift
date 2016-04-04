//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by Jason Zheng on 4/4/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class PreferenceManager {
  let userDefaults = NSUserDefaults.standardUserDefaults()
  
  private let speakTextKey = "Speak Text"
  private let speakVoiceKey = "Speak Voice"
  
  let defaultSpeakText = ""
  let defaultSpeakVoice = NSSpeechSynthesizer.defaultVoice()
  
  var speakText: String {
    get {
      return (userDefaults.objectForKey(speakTextKey) as? String) ?? defaultSpeakText
    }
    
    set {
      userDefaults.setObject(newValue, forKey: speakTextKey)
    }
  }
  
  var speakVoice: String {
    get {
      return (userDefaults.objectForKey(speakVoiceKey) as? String) ?? defaultSpeakVoice
    }
    
    set {
      userDefaults.setObject(newValue, forKey: speakVoiceKey)
    }
  }
  
  init() {
    registerFactoryDefaults()
  }
  
  func registerFactoryDefaults() {
    let factoryDefaults = [
      speakTextKey: defaultSpeakText,
      speakVoiceKey: defaultSpeakVoice
    ]
    
    userDefaults.registerDefaults(factoryDefaults)
  }
  
  func resetFactoryDefaults() {
    userDefaults.removeObjectForKey(speakTextKey)
    userDefaults.removeObjectForKey(speakVoiceKey)
  }
  
  func synchronize() {
    userDefaults.synchronize()
  }
}

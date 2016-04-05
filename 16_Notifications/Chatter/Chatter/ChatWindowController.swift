//
//  ChatWindowController.swift
//  Chatter
//
//  Created by Jason Zheng on 4/5/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ChatWindowController: NSWindowController {

  private let notificationCenter = NSNotificationCenter.defaultCenter()
  
  let ChatMessageNotificationDidSent = "com.atjason.swift.cocoa.chatter.ChatMessageNotificationDidSent"
  let ChatMessageNotificationNameKey = "Name"
  let ChatMessageNotificationMessageKey = "Message"
  
  @IBOutlet var messageView: NSTextView!
  @IBOutlet weak var nameTextField: NSTextField!
  @IBOutlet weak var messageTextField: NSTextField!
  
  dynamic var messageHistory = NSAttributedString(string: "")
  dynamic var name = ""
  dynamic var message = "" {
    didSet {
      messageIsNotEmpty = !message.isEmpty
    }
  }
  
  dynamic var messageIsNotEmpty = false
  
  // MARK: - lifecycle
  
  override var windowNibName: String? {
    return "ChatWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()

    // TODO: double check for selector
    notificationCenter.addObserver(self, selector: #selector(ChatWindowController.receiveMessage),
                                   name: ChatMessageNotificationDidSent, object: nil)
  }
  
  
  
  deinit {
    notificationCenter.removeObserver(self)
  }
  
  // MARK: - Functions
  
  func receiveMessage(notification: NSNotification) {
    if let dict = notification.userInfo as? [String: String] {
      if let message = dict[ChatMessageNotificationMessageKey] {
        if let name = dict[ChatMessageNotificationNameKey] {
          
          let mutableMessageHistory = messageHistory.mutableCopy()
          
          if messageHistory.length > 0 {
            mutableMessageHistory.appendAttributedString(NSAttributedString(string: "\n"))
          }
          
          let messageLine = "\(name): \(message)"
          mutableMessageHistory.appendAttributedString(NSAttributedString(string: messageLine))
          
          messageHistory = mutableMessageHistory.mutableCopy() as! NSAttributedString
          
          messageView.scrollToEndOfDocument(self)
        }
      }
    }
  }
  
  // MARK: - Actions
  
  @IBAction func sendMessage(sender: NSButton) {
    
    sender.window?.endEditingFor(nil)
    
    if !message.isEmpty {
      let realName = name.isEmpty ? "Ghost" : name
      
      let userInfo = [
        ChatMessageNotificationNameKey: realName,
        ChatMessageNotificationMessageKey: message
      ]
      
      notificationCenter.postNotificationName(ChatMessageNotificationDidSent,
                                              object: self, userInfo: userInfo)
      
      message = ""
    }
  }
}

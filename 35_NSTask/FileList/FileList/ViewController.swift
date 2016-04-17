//
//  ViewController.swift
//  FileList
//
//  Created by Jason Zheng on 4/17/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet var textView: NSTextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  // MARK: - Action
  
  @IBAction func openFolder(sender: NSButton) {
    let defaultFolderURL: NSURL
    do {
      defaultFolderURL = try NSFileManager.defaultManager().URLForDirectory(
        NSSearchPathDirectory.DownloadsDirectory,
        inDomain: NSSearchPathDomainMask.UserDomainMask,
        appropriateForURL: nil, create: false)
      
    } catch {
      defaultFolderURL = NSURL(fileURLWithPath: "~/Downloads")
    }
    
    let openPanel = NSOpenPanel()
    openPanel.directoryURL = defaultFolderURL
    openPanel.canChooseDirectories = true
    openPanel.canChooseFiles = false
    openPanel.prompt = "Open"
    
    let selection = openPanel.runModal()
    
    if selection == NSFileHandlingPanelOKButton {
      if let selectedURL = openPanel.URL {
        if let content = getFileListOf(selectedURL) {
          if let attrStr = textView.textStorage as? NSMutableAttributedString {
            attrStr.replaceCharactersInRange(NSRange(0..<attrStr.length), withString: content)
          }
        }
      }
    }

  }
  
  // MARK: - Helper
  
  func getFileListOf(path: NSURL) -> String? {
    
//    return nil
    return path.absoluteString
  }
}


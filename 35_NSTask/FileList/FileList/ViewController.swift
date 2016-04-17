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
      if let path = openPanel.URL?.path {
        if let content = getFileListOf(path) {
          if let textStorage = textView.textStorage {
            textStorage.replaceCharactersInRange(NSRange(0..<textStorage.length), withString: content)
          }
        }
      }
    }
  }
  
  // MARK: - Helper
  
  func getFileListOf(path: String) -> String? {
    let task = NSTask()
    task.launchPath = "/bin/ls"
    task.arguments = ["-l", path]
    
    let pipe = NSPipe()
    task.standardOutput = pipe
    
    task.launch()
    task.waitUntilExit()
    
    let fileHandler = pipe.fileHandleForReading
    let data = fileHandler.readDataToEndOfFile()
    
    if task.terminationStatus != 0 {
      NSLog("Failed to open file list. Reason: \(task.terminationReason)")
      return nil
    }
    
    return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
  }
}


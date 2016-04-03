//
//  Document.swift
//  RaiseMan
//
//  Created by Jason Zheng on 4/3/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

  override init() {
      super.init()
    // Add your subclass-specific initialization here.
  }

  override class func autosavesInPlace() -> Bool {
    return true
  }

  override var windowNibName: String? {
    // Returns the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
    return "Document"
  }

}

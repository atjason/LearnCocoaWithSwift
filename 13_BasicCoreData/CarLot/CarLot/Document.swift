//
//  Document.swift
//  CarLot
//
//  Created by Jason Zheng on 4/3/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {
  
  @IBOutlet weak var tableView: NSTableView!

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
  
  @IBAction func editCar(sender: NSButton) {
    let row = tableView.selectedRow
    tableView.editColumn(0, row: row, withEvent: nil, select: true)
  }
}

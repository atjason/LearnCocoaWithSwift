//
//  AppDelegate.swift
//  GeneratePassword
//
//  Created by Jason Zheng on 3/31/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainWindowController = MainWindowController()
        
        mainWindowController.showWindow(self)
        
        // Best practice in Swift:
        //   Create an object and complete its initial work 
        //     before saving the object to a property.
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    
    }
}


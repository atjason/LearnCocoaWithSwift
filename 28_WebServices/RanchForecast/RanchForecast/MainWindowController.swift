//
//  MainWindowController.swift
//  RanchForecast
//
//  Created by Jason Zheng on 6/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  let fetcher = ScheduleFetcher()
  dynamic var courses = [Course]()
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    
    fetcher.fetchCourses { (fetchCourseResult) in
      switch fetchCourseResult {
      case .Succeed(let courses):
        self.courses = courses
        
        print("Get courses: \(courses)")
        
      case .Failed(let error):
        self.courses = []
        
        print("Get error: \(error)")
      }
    }
  }
}

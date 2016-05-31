//
//  ScheduleFetcher.swift
//  RanchForecast
//
//  Created by Jason Zheng on 6/1/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Foundation

class ScheduleFetcher {
  enum FetchCoursesResult {
    case Succeed([Course])
    case Failed(NSError)
  }
  
  let session: NSURLSession
  
  init() {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    session = NSURLSession(configuration: config)
  }
  
  func fetchCourses(completionHandler: (FetchCoursesResult) -> Void) {
    let url = NSURL(string: "https://bookapi.bignerdranch.com/courses.json")!
    let request = NSURLRequest(URL: url)
    let task = session.dataTaskWithRequest(request) { (data, response, error) in
      var fetchCourseResult: FetchCoursesResult
      if let data = data {
        print("Data length: \(data.length)")
        fetchCourseResult = FetchCoursesResult.Succeed([])
      } else {
        fetchCourseResult = FetchCoursesResult.Failed(error!)
      }
      
      NSOperationQueue.mainQueue().addOperationWithBlock {
        completionHandler(fetchCourseResult)
      }
    }
    task.resume()
  }
}
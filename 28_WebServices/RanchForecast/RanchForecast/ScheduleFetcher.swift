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
      if data == nil {
        fetchCourseResult = FetchCoursesResult.Failed(error!)
        
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == 200 {
          fetchCourseResult = self.parseCoursesFrom(data!)
          
        } else {
          fetchCourseResult = FetchCoursesResult.Failed(
            self.errorWithCode(2, localizedDescription: "Http response status code: \(httpResponse.statusCode)."))
        }
        
      } else {
        fetchCourseResult = FetchCoursesResult.Failed(
          self.errorWithCode(1, localizedDescription: "Invalid response."))
      }
      
      NSOperationQueue.mainQueue().addOperationWithBlock {
        completionHandler(fetchCourseResult)
      }
    }
    task.resume()
  }
  
  func parseCoursesFrom(data: NSData) -> FetchCoursesResult {
    var fetchError: NSError?
    do {
      if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary {
        if let coursesDict = json["courses"] as? [NSDictionary] {
          var courses = [Course]()
          
          for dict in coursesDict {
            if let course = parseCourseFrom(dict) {
              courses.append(course)
            }
          }
          
          return FetchCoursesResult.Succeed(courses)
        } else {
          fetchError = errorWithCode(4, localizedDescription: "Failed to courses dictionary.")
        }
      }
      
    } catch {
      fetchError = errorWithCode(4, localizedDescription: "Failed to generate JSON object.")
    }
    
    return FetchCoursesResult.Failed(fetchError!)
  }
  
  func parseCourseFrom(dict: NSDictionary) -> Course? {
    var course: Course?
    if let title = dict["title"] as? String, urlString = dict["url"] as? String, upcoming = dict["upcoming"] as? [NSDictionary] {
      if let url = NSURL(string: urlString), startDateString = upcoming.first?["start_date"] as? String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.dateFromString(startDateString) {
          course = Course(title: title, url: url, nextStartDate: date)
        }
      }
    }
    return course
  }
  
  func errorWithCode(code: Int, localizedDescription: String) -> NSError {
    return NSError(domain: "ScheduleFetcher", code: code,
                   userInfo: [NSLocalizedDescriptionKey: localizedDescription])
  }
}
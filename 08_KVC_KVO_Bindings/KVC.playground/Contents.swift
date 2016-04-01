
import Foundation

// Must inherit from NSObject as the KVC methods are defined on NSObject.
class Person: NSObject {
  var name = ""
  var age = 0
}

var person = Person()

person.setValue("Tom", forKey: "name")
person.setValue(30, forKey: "age")

person.valueForKey("name") as? String // Tom
person.valueForKey("age") as? Int     // 30

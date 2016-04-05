#Closures and capturing
Swift closures can capture constants and variables that are within scope. 

But, this powerful feature has the disadvantage of potentially creating a strong reference cycle if the captured object reference has a strong reference to the closure.

The solution is to use a capture list:

```swift
    alert.beginSheetModalForWindow(window!, completionHandler: {
      [unowned self] (response) -> Void in
      
      //self.xxx
      
     }
    })
```


Capture lists allow you describe how reference types are captured. Two keywords come into play here:
 
* **unowned**
If the reference being captured should never be deallocated before the closure, use unowned.

* **weak**
If the reference may be deallocated before the closure, use weak.


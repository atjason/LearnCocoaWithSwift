[NSTimer Class Reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/)

# Create a Scheduled Timer

```swift
class func scheduledTimerWithTimeInterval(ti: NSTimeInterval,
                    target aTarget: AnyObject,
                    selector aSelector: Selector,
                    userInfo: AnyObject?,
                    repeats yesOrNo: Bool) -> NSTimer
```

Notice that this is a class method on NSTimer.

# Timer Usage

```swift
func fire()				// Manually start timer
func invalidate()		// Stop timer, remove timer from NSRunLoop.
var tolerance: NSTimeInterval // Set to save energy
```

# NSTimer and Strong/Weak References

When a timer is scheduled, the run loop keeps a strong reference to the timer. We would say that the run loop “owns” the timer. Thus it is unnecessary to keep a strong reference to it yourself.

In some cases, it is unnecessary to keep any sort of reference at all. **Generally speaking NSTimer references are only needed in order to invalidate the timer or to determine whether it is still running**. In this case you should use an optional weak reference:

```swift
weak var timer: NSTimer?
```

Weak because the run loop owns the timer, and optional because weak references in Swift must be optionals.



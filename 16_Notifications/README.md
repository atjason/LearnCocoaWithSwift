#Delegates and Notifications

If a standard Cocoa object has a delegate and posts notifications, the delegate is automatically registered as an observer for the methods it implements. 

If you are implementing such a delegate, how would you know what to call the method? The naming convention is simple: 

- Start with the name of the notification. 
- Remove the NS from the beginning and make the first letter lowercase. 
- Remove the Notification from the end. Add a colon. 

For example, 
NSApplicationDidFinishLaunchingNotification
->
**applicationDidFinishLaunching**


```swift
public let NSApplicationDidFinishLaunchingNotification: String
public protocol NSApplicationDelegate : NSObjectProtocol {
    optional public func applicationDidFinishLaunching(notification: NSNotification)
}
```


# NSResponder

NSView inherits from NSResponder. All the event-handling methods are declared in NSResponder. NSResponder declares these methods:
```swift
    func mouseDown(theEvent: NSEvent)
    func rightMouseDown(theEvent: NSEvent)
    func otherMouseDown(theEvent: NSEvent)

    func mouseUp(theEvent: NSEvent)
    func rightMouseUp(theEvent: NSEvent)
    func otherMouseUp(theEvent: NSEvent)

    func mouseDragged(theEvent: NSEvent)
    func scrollWheel(theEvent: NSEvent)
    func rightMouseDragged(theEvent: NSEvent)
    func otherMouseDragged(theEvent: NSEvent)
```
Notice that the argument is always an NSEvent object.

# NSEvent

[NSEvent Class Reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSEvent_Class/)
An event object has all the information about what the user did to trigger the event. When you are dealing with mouse events, you might be interested in the following properties:

```swift
var locationInWindow: NSPoint { get }
var modifierFlags: NSEventModifierFlags { get }
var timestamp: NSTimeInterval { get }
unowned(unsafe) var window: NSWindow! { get }
var clickCount: Int { get }
var pressure: Float { get }
var deltaX: CGFloat { get }
var deltaY: CGFloat { get }
var deltaZ: CGFloat { get }
```
# Convert Location in Window and View

```swift
    func convertPoint(aPoint: NSPoint, fromView aView: NSView?) -> NSPoint
    func convertPoint(aPoint: NSPoint, toView aView: NSView?) -> NSPoint
```

Although these methods take references to views as their second parameter, passing `nil` as the view results in converting to/from the view’s window. To convert `locationInWindow` to the view you will call `convertPoint(_:fromView:)` with `nil` for the view.





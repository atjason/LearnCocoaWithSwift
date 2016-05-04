# NSResponder

Keyboard events related property and methods that are inherited from NSResponder: 
```swift
var acceptsFirstResponder: Bool { get }
func resignFirstResponder() -> Bool
func becomeFirstResponder() -> Bool
func keyDown(theEvent: NSEvent)
func keyUp(theEvent: NSEvent)
func flagsChanged(theEvent: NSEvent)
```

# NSEvent

Here are some of the properties commonly used when getting information about a keyboard event:

```swift
var characters: String! { get }
var ARepeat: Bool { get }
var keyCode: UInt16 { get }
var modifierFlags: NSEventModifierFlags { get }
```

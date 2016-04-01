# 3 Steps to Use Delegate

1. **Conform**
Conform a class to the delegate protocol
2. **Implement**
Implement the protocol
3. **Set**
Set the delegate to instance of the class


# Common errors in implementing a delegate

1. **Forgetting to set the delegate property**
**Solution**: Double check the 3 steps after you thing you've finished.

2. **Misspelling the name of an optional delegate method**
*delegate* method names are often long and unwieldy, and if you misspell an optional method from a protocol, the compiler will treat as you declare a new function.
**Solution**: Use auto-complete when typing them in. If you do not know the method name well enough to start typing it, copy the method declaration from the documentation or from the protocol’s header file. 

# @NSApplicationMain

    @NSApplicationMain
    class AppDelegate: NSObject, NSApplicationDelegate {}

This line triggers the essential steps to launching a Cocoa application:

- Instantiating the **NSApplication** and the **AppDelegate**
- Setting the **NSApplication**’s *delegate* property to the **AppDelegate**.

# Cocoa applications are event-driven.

Thus, a big part of learning Cocoa is learning the right methods to implement to get your code executed at the right time.

- **action methods**
- **delegate methods**
- **notification observers**

# NSFont

Overall, the class NSFont has only two types of methods:

- class methods for getting the font you want
- methods for getting metrics on the font, such as letter height

The following are commonly used methods in NSFont: 

```swift
  class func systemFontOfSize(fontSize: CGFloat) -> NSFont!
  class func boldSystemFontOfSize(fontSize: CGFloat) -> NSFont!
  class func labelFontOfSize(fontSize: CGFloat) -> NSFont!

  class func userFontOfSize(fontSize: CGFloat) -> NSFont!
  class func userFixedPitchFontOfSize(fontSize: CGFloat) -> NSFont!

  class func titleBarFontOfSize(fontSize: CGFloat) -> NSFont!
  class func messageFontOfSize(fontSize: CGFloat) -> NSFont!
  class func toolTipsFontOfSize(fontSize: CGFloat) -> NSFont!
```
These methods return a font object for the user’s default font for the corresponding string types. If you supply a fontSize of 0.0, these methods will use the default font size.

User fonts are intended to be used in areas representing user input: a text field, for example. The other methods are useful when implementing custom user interface controls.

```swift
  init(name fontName: String!, size fontSize: CGFloat) -> NSFont
```
This method initializes a font object by name. fontName is the family face name, such as “HelveticaBoldOblique” or “Times-Roman”. Again, a fontSize of 0.0 uses the default font size.
Unless your application calls for using a specific font, we recommend using the prior set of methods in place of this one, in order to **maintain consistency with the system**.

# NSAttributedString

[NSAttributedString Class Reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/)

When dealing with a range of numbers, Cocoa uses the struct `NSRange`. `NSRange` has two members, location and length, which are both integers.

- The location is the index of the first item
- The length is the number of items in the range.

You can use the function `NSMakeRange()` to create an `NSRange`, but in Swift it is more expedient to use the range expression initializer: `NSRange(0...4)`.

# Drawing Strings and Attributed Strings

Both NSString and NSAttributedString have methods that cause them to be drawn onto a view. NSAttributedString has the following methods:

```swift
func drawAtPoint(point: NSPoint)
func drawInRect(rect: NSRect)
var size: NSSize { get }
```

NSString has analogous methods. With NSString, you need to supply a dictionary of attributes to be applied for the entire string.

```swift
func drawAtPoint(point: NSPoint, withAttributes attrs: [NSObject : AnyObject]!)
func drawInRect(rect: NSRect, withAttributes attrs: [NSObject : AnyObject]!)
func sizeWithAttributes(attrs: [NSObject : AnyObject]!) -> NSSize
```
Note that these are methods on NSString, not Swift’s String. To use them on String objects you must simply cast to an NSString using as.

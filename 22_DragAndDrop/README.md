# NSDragOperation

The user can perform several different operations by dragging from one application to another, or even between views in the same application. These operations are represented by the NSDragOperation type.

```swift
struct NSDragOperation : RawOptionSetType {
    static var None: NSDragOperation { get }
    static var Copy: NSDragOperation { get }
    static var Link: NSDragOperation { get }
    static var Generic: NSDragOperation { get }
    static var Private: NSDragOperation { get }
    static var Move: NSDragOperation { get }
    static var Delete: NSDragOperation { get }
    static var Every: NSDragOperation { get }
}
```

For example, nothing may happen (`.None`), a copy of the data may be created (`.Copy`), or the data may be moved (`.Move`).

# Make a View be Drag Source

To be a drag source, your view must conform to the `NSDraggingSource` protocol. Only one method is required, `draggingSession(_:sourceOperationMaskForDraggingContext:)`. This method declares what operations the view is willing to participate in as a source.

When a drag is started, this method is automatically called **twice**: 

- once with context as `.WithinApplication`, which determines what operations it is willing to participate in for destinations within your application; 
- and a second time, with context as `.OutsideApplication` which determines what operations it is willing to participate in for destinations in other applications. 

# Make DieView a Drag Destination

There are several parts to being a drag destination. 

First, you need to declare your view a destination for the dragging of certain types. NSView has a method for this purpose: 

```swift
func registerForDraggedTypes(newTypes: [AnyObject])
```

You typically call this method in your initWithFrame: method.

Then you need to implement six methods. (Yes, six!) All six methods have the same argument: an object that conforms to the NSDraggingInfo protocol. That object provides the dragging pasteboard. The six methods are invoked as follows:

1. As the image is dragged into the destination, the destination is sent a `draggingEntered(_:)` message. Often, the destination view updates its appearance. For example, it might highlight itself.
2. While the image remains within the destination, a series of `draggingUpdated(_:)` messages are sent. Implementing `draggingUpdated(_:)` is optional.
3. If the image is dragged outside the destination, `draggingExited(_:)`is sent.
4. If the image is released on the destination, either it slides back to its source (and breaks the sequence) or a `prepareForDragOperation(_:)` message is sent to the destination, depending on the value returned by the most recent invocation of `draggingEntered(_:)` (or `draggingUpdated(_:)` if the view implemented it).
5. If the `prepareForDragOperation(_:)` message returns true, then a `performDragOperation(_:)` message is sent. This is typically where the application reads data off the pasteboard.
6. Finally, if `performDragOperation(_:)` returned true, `concludeDragOperation(_:)` is sent. The appearance may change. This is where you might generate the big gulping sound that implies a successful drop.



# KVC (Key-Value Coding) 

KVC is a mechanism that allows you to get and set the value of a property indirectly using a key. A key is the name of a property as a string.

Many Cocoa features rely on the ability of KVC to get and set values by key, e.g., Cocoa bindings.

# KVO (Key-Value Observing)

# Bindings

Bindings are an abstraction layer on top of KVO and KVC which keep your Cocoa views in sync with the model objects they are bound to.

# 3 Ways to Let Changes be KVO-compliant
In order for KVO to see changes, the changes must be made in a KVO-compliant manner.

1. Change using KVC

  `setValue(newTemperature, forKey: "temperature")`

2. Explicitly trigger notification of the observers

  `willChangeValueForKey("temperature");
  temperature++;
  didChangeValueForKey("temperature")`

3. Make the property **dynamic**

  `dynamic var temperature = 68`

# dynamic

The **dynamic** keyword is not specific to KVO; it makes the property behave like an Objective-C property so that it can benefit from the runtime flexibility that Objective-C offers. Using KVO with bindings is one of those benefits.

# Benefit of Bindings

Bindings can simplify and even eliminate code that links the view layer and the model layer of an application.

# Disadvantage of Bindings

## 1. Performance

Observers of KVO-compliant properties are notified immediately after the property is changed. This can affect performance or result in surprising behavior in multi-threaded apps. In these cases you will want the control offered by the `willChangeValueForKey(_:) and didChangeValueForKey(_:)` methods.

## 2. Debug

When you use KVC, you are abandoning Swift’s type safety, and if not used carefully this can result in runtime errors that are hard to debug.

# Best Practice for Bindings

- For a relatively straightforward UI, bindings make an excellent choice.
- For more complicated user interfaces, write code but not using binding. 
- As you gain more experience with bindings, try using Binding in more complicated cases.

# Pattern of a computed property with separate backing storage

      private var privateIsOn = true
      dynamic var isOn: Bool {
        get {
          return privateIsOn
        }
        
        set {
          privateIsOn = newValue
        }
      }

  
Use this pattern to control access to a value.

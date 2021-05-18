# Runtime

封装ObjectiveC模块，学习Objective-C的Runtime

## Usage

```swift
import Runtime

// MARK: - Runtime class

@objcMembers
class Class {
    var property = 1
}

print(Rclass.getName(Class.self))
print(Rclass.getSuperclass(Class.self) as Any)
print(Rclass.isMetaClass(Class.self))
print(Rclass.getInstanceSize(Class.self))
print(Rclass.getInstanceVariable(Class.self, name: "property")!.getName())
print(Rclass.getIvarList(Class.self).map { $0.getName() })
print(Rclass.getProperty(Class.self, name: "property")!.getName())
print(Rclass.addProperty(Class.self, name: "newProperty", type: "NSString"))
print(Rclass.getPropertyList(Class.self).map { $0.getName() })

// MARK: - Runtime object

let object = Class()

print(Robject.getClassName(object))
print(Robject.getClass(object)!)

// MARK: - Runtime Objective-C

let NewClass: AnyClass? = Robjc.allocateClass(RNSObject.self, name: "NewClass")
print(Robjc.getClass("NewClass") ?? "")
Robjc.registerClass(NewClass!)
print(Robjc.getClass("NewClass")!)
print(Robjc.getMetaClass("NewClass")!)
Robjc.disposeClass(NewClass!)
print(Robjc.getClass("NewClass") ?? "")
```

## Installation

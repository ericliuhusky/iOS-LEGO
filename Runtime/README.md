# Runtime

Swift中的Runtime

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




// MARK: - Runtime Foundation utilities

print(Rutil.getNameFromClass(Class.self))
print(Rutil.getClassFromName("Class") as Any)


// MARK: - Runtime based NSObject KVC

@objcMembers
class KVC: RNSObject {
    var a = 1
    var b: Int? = nil
}

let kvc = KVC()

print(Rkvc.getValue(kvc, key: "a") as Any)
Rkvc.setValue(kvc, value: 2, key: "a")
print(Rkvc.getValue(kvc, key: "a") as Any)

// NSUnknownKeyException
//print(Rkvc.getValue(kvc, key: "b"))
//Rkvc.setValue(kvc, value: 2, key: "b")
//print(Rkvc.getValue(kvc, key: "b"))


// MARK: - Runtime based NSObject KVO

@objcMembers
class KVOsubject: Rkvo.Subject {
    dynamic var a = 1
    dynamic var b: Int? = nil
}

class KVOobserver: Rkvo.Observer {
    override func update(subject: Rkvo.Subject?, state: KeyValuePairs<String?, Any?>) {
        print(subject as Any, state)
    }
}

let subject = KVOsubject()
let observer = KVOobserver()
subject.addObserver(observer, forKeyPath: "a")
subject.a = 1
subject.a = 2
subject.addObserver(observer, forKeyPath: "b")
subject.b = 1
subject.b = 2


```

## Installation

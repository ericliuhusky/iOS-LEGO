# KVC与KVO中的崩溃

## KVC

1. 没有@objc标记

```swift
class KVC: NSObject {
    var a = 1
}

// Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Main.KVC 0x1005ac520> valueForUndefinedKey:]: this class is not key value coding-compliant for the key a.'
KVC().value(forKey: "a")
```

2. 访问不存在的属性关键字

```swift
class KVC: NSObject {
    @objc var a = 1
}

// Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Main.KVC 0x10058bb20> valueForUndefinedKey:]: this class is not key value coding-compliant for the key b.'
KVC().value(forKey: "b")
```

3. 属性值为nil

```swift
class KVC: NSObject {
    var a: Int? = nil
}

// Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Main.KVC 0x100509cc0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key a.'
KVC().value(forKey: "a")
```


## KVO

- 重复移除观察者

```swift
class KS: NSObject {
    @objc dynamic var a = 1
}

class KO: NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change?[.newKey] as Any)
    }
}

let s = KS()
let o = KO()
s.addObserver(o, forKeyPath: "a", options: .new, context: nil)
s.a = 1
s.a = 2
s.a = 3
s.removeObserver(o, forKeyPath: "a")

// Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <Main.KO 0x10070bc00> for the key path "a" from <Main.KS 0x10070bb30> because it is not registered as an observer.'
s.removeObserver(o, forKeyPath: "a")
```

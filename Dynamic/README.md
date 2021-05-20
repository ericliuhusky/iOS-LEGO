# Dynamic

swift 中的动态特性Dynamic Feature

## Usage

```swift

// MARK: - Dynamic Support for Dynamic Language

// dynamic member look up

let json = JSON.dictionary(
    [
        "a": .array([.int(1), .int(2)]),
        "b": .string("b"),
        "c": .int(3)
    ]
)

print(json.a?[0]?.int as Any)
print(json.b?.string as Any)
print(json.c?.int as Any)
print(json["c"]?.int as Any)


// dynamic call

import JavaScriptCore

let context: JSContext = JSContext()
context.evaluateScript(
"""
function sum(a, b) {
    return a + b
}
"""
)
let sumValue: JSValue = context.evaluateScript("sum")

let sum = JSFunctionWrapper(value: sumValue)
print(sumValue.call(withArguments: [1, 2]) as Any)
print(sum(1, 2))




// MARK: - Mirror

class A {
    var a = 1
}

class B: A {
    var b = 2
}

class C {
    var c = B()
    var b = 1
}

dump(C())

print(Dmirror(reflecting: C()).getPropertyDictionary())


```

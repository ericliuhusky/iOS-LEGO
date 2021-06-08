# For-In快速循环中的崩溃

## Objective-C

### 崩溃现场

```objc
NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, nil];

// NSGenericException: Collection <__NSArrayM: 0x10496beb0> was mutated while being enumerated.
for (NSNumber* a in array) {
    if (a.integerValue == 2) {
        [array removeObject:a];
    }
}

NSLog(@"%@", array);
```

### 崩溃原因

Objective-C中for-in快速循环不可以在遍历的时候改变原数组的值

### 如何解决？

1. break退出迭代

```objc
NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, nil];

for (NSNumber* a in array) {
    if (a.integerValue == 2) {
        [array removeObject:a];
        // MARK: fixed
        break;
    }
}

NSLog(@"%@", array);
```

2. 复制原数组

```objc
NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, nil];

// MARK: fixed
NSMutableArray *copy = [array mutableCopy];
for (NSNumber* a in copy) {
    if (a.integerValue == 2) {
        [array removeObject:a];
    }
}

NSLog(@"%@", array);
```

3. 临时变量保存

```objc
NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, nil];

NSNumber* temp;
for (NSNumber* a in array) {
    if (a.integerValue == 2) {
        temp = a;
    }
}
// MARK: fixed
if (temp != nil) {
    [array removeObject:temp];
}

NSLog(@"%@", array);
```

4. 使用经典for循环

```objc
NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, nil];

// MARK: fixed
for (int i = 0; i < array.count; i++) {
    NSNumber* a = [array objectAtIndex:i];
    if (a.integerValue == 2) {
        [array removeObject:a];
    }
}

NSLog(@"%@", array);
```


## Swift

### 试图重现Objective-C崩溃现场

```swift
var array = [1, 2, 3, 4]

for a in array {
    if a == 2 {
        array.removeAll { $0 == a }
    }
}

print(array)
```

```swift
let array = NSMutableArray(array: [1, 2, 3, 4])

for a in array {
    if a as! Int == 2 {
        array.remove(a)
    }
}

print(array)
```

### 为何同样的代码在Swift中不会崩溃？

1. 查阅官方文档

从Apple Developer Documentation中找到这么一句话"Swift uses a sequence’s or collection’s iterator internally to enable the for-in loop language construct."，Swift内部使用Sequence或Collection的迭代器来启用for-in循环的语言构造。

2. 构建遵循迭代器协议的自定义类型来使用for-in循环

```swift
struct _Array: Sequence, IteratorProtocol {
    let value = [1, 2, 3, 4, 5]
    var index: Int = 0

    mutating func next() -> Int? {
        guard index < value.count else { return nil }
        defer {
            index += 1
        }
        return value[index]
    }
}

var iter = _Array().makeIterator()
while let item = iter.next() {
    print(item)
}

for a in _Array() {
    print(a)
}
```

3. 从源代码入手解决疑惑

```swift
extension Array: RandomAccessCollection, MutableCollection {
  public typealias Iterator = IndexingIterator<Array>
}

@frozen
public struct IndexingIterator<Elements: Collection> {
    @usableFromInline
    internal let _elements: Elements
    @usableFromInline
    internal var _position: Elements.Index

    @inlinable
    @inline(__always)
    public
    init(_elements: Elements) {
    self._elements = _elements
    self._position = _elements.startIndex
    }
}

extension IndexingIterator: IteratorProtocol, Sequence {
    public typealias Iterator = IndexingIterator<Elements>

    @inlinable
    @inline(__always)
    public mutating func next() -> Elements.Element? {
        if _position == _elements.endIndex { return nil }
        let element = _elements[_position]
        _elements.formIndex(after: &_position)
        return element
    }
}

extension Sequence where Self.Iterator == Self {
    @inlinable
    public __consuming func makeIterator() -> Self {
    return self
    }
}
```

从以上只保留关键内容的源码可以看出：

Array遵循MutableCollection协议，MutableCollection协议继承Collection协议，Collection协议继承Sequence协议；

Array中Iterator是IndexingIterator，IndexingIterator遵循Sequence协议，而Sequence协议的扩展又声明当Iterator别名等于自身时，makeIterator()返回自身；

观察源码发现迭代器根据_elements来工作，在Swift中Array是struct值类型，IndexingIterator初始化向_elements传值时会深拷贝复制；

因此Array在进行for-in循环时，迭代器会使用值类型深拷贝的方式，将原数组完全复制一份，这样很自然的在遍历过程中改变原数组的值不会发生任何影响；

打印出NSMutableArray的迭代器发现是NSFastEnumerationIterator类型，NS相关的类型都是class引用类型，如果NSFastEnumerationIterator和IndexingIterator一样
直接给_elements赋值，那么对原数组的更改一定会影响到迭代器，即便不报错迭代也会和正常不同，可是我们发现迭代丝毫不受影响；因此猜测Swift在兼容NSFastEnumeration时，
额外对引用类型数据进行了深拷贝，之后再赋值给_elements


## 对Objectiv-C中崩溃的深入思考

### 崩溃原因

既然Swift中使用深拷贝的方式复制一份不会发生任何影响，那么Objective-C中崩溃的原因是否是因为对原数组进行了浅拷贝呢？

查阅相关资料发现Objective-C中for-in快速循环对原数组进行了浅拷贝，在遍历过程中改变原数组会改变迭代器内的值，会让迭代器不知道下一步应该如何迭代，因此Objective-C中直接抛出了Exception，不允许程序在遍历过程中改变原数组的值，以避免产生不符合预期的结果。

### 为何能解决？

1. break退出迭代

删除原数组的某个项之后，退出迭代，尽管迭代器不知道下一步应该如何迭代，但已经退出了迭代因此没有问题；
包括不加break时删除数组的最后一个项也没有问题，删除最后一个项时迭代已经结束也不会有问题

2. 复制原数组

复制原数组，使用复制的数组来进行迭代，删除原数组的项不会影响到复制的数组，进而不会影响到迭代

3. 临时变量保存

临时保存要删除的项，等迭代结束之后再进行删除，迭代结束之后自然不会影响到迭代过程

4. 使用经典for循环

经典for循环，使用的是index索引，与for-in快速循环的迭代器根本没有关系，因此不会崩溃；

值得一提的是，虽然不会崩溃，但不代表使用经典for循环没有一点问题，在遍历过程中改变原数组，依然会使经典for循环产生不符合预期的结果；
遍历结果变成了124

### 使用Swift复现Objective-C中的迭代

```swift
protocol _Sequence {
    associatedtype Iterator

    func makeIterator() -> Self.Iterator
}

protocol _IteratorProtocal {
    mutating func next() -> Int?
}

class _Array: _Sequence {
    typealias Iterator = _Iterator
    
    var value: [Int]
    
    init(value: [Int]) {
        self.value = value
    }

    func makeIterator() -> Iterator {
        return _Iterator(value: self)
    }
    
    var count: Int {
        value.count
    }
    
    subscript(index: Int) -> Int {
        value[index]
    }

    func remove(item: Int) {
        value.removeAll { $0 == item }
    }
}


struct _Iterator: _IteratorProtocal {
    let value: _Array
    var index: Int = 0

    init(value: _Array) {
        self.value = value
    }

    mutating func next() -> Int? {
        guard index < value.count else { return nil }
        defer {
            index += 1
        }
        return value[index]
    }
}

var array = _Array(value: [1, 2, 3, 4, 5])
var iter = array.makeIterator()

while let item = iter.next() {
    if item == 2 {
        array.remove(item: item)
    }
    print(item)
}
print(array.value)
/*
print result
1
2
4
5
[1, 3, 4, 5]
*/
```

在这里构建了一个引用类型的数组，打印结果本应该是12345，实际结果却少了3；在第二次迭代中删除了2，导致原来的数组变为[1,3,4,5]，迭代还要继续，此时迭代器内部的索引变为了2，
对应索引为2的项已经变成了4，继续迭代产生结果1245

### 经典for循环

在Swift和Objective-C中使用经典for循环，在遍历过程中改变原数组，都会产生不符合预期的遍历结果，因此Swift3中直接弃用了经典for循环；

在Swift中使用for-in循环不存在任何问题，既没有崩溃也不会有不符合预期的结果，都是得益于迭代器对值类型深拷贝；
当为自定义类型添加for-in循环的扩展时，如果是引用类那么需要注意手动深拷贝，如果是值结构体则不需要考虑太多

在Objective-C中使用for-in循环，如果要对原数组进行更改，那么要注意手动深拷贝一份，或者临时变量保存等到迭代结束再更改；
经典for循环虽然不会崩溃，但仍然会产生不符合预期的遍历结果

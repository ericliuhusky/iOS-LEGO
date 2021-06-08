# 多线程中的崩溃

## 死锁

```swift
DispatchQueue.main.sync {
    print("deadlock")
}
```

## 数据竞争

```swift
// 并行队列导致a最终不一定等于1000

var a = 0
let cq = DispatchQueue(label: "concurrent", attributes: .concurrent)
for _ in 0..<1000 {
    cq.async {
        a += 1
    }
}
print(a)
```

```swift
// 串行队列可以保证a最终等于1000

var a = 0
let sq = DispatchQueue(label: "serial")
for _ in 0..<1000 {
    sq.async {
        a += 1
    }
}
print(a)
```

```swift
// 给并行队列加上.barrier标志也可以保证a最终等于1000

var a = 0
let cq = DispatchQueue(label: "concurrent", attributes: .concurrent)
for _ in 0..<1000 {
    cq.async(flags: .barrier) {
        a += 1
    }
}
print(a)
```

```swift
// 给操作加锁，也能保证a最终等于1000

let lock = NSLock()
var a = 0
let cq = DispatchQueue(label: "concurrent", attributes: .concurrent)
for _ in 0..<1000 {
    cq.async {
        lock.lock()
        a += 1
        lock.unlock()
    }
}
print(a)
```

## 子线程更新UI


## Socket长连接进入后台要关闭

## 主线程超时

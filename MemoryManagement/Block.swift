// 闭包中的循环引用

class A {
    var block: () -> Void = {}

    init() {
        print("初始化\(self)")

        // weak
        block = { [weak self] in
            print(self as Any)
        }
    }

    deinit {
        print("释放\(self)")
    }
}

var a: A? = A()
a = nil

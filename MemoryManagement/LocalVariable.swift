// 局部变量中的内存管理

class A {
    init() {
        print("初始化\(self)")
    }

    deinit {
        print("释放\(self)")
    }
}

class B {
    var a: A?

    func f() {
        let a = A()
        self.a = a
    }
}

var b: B? = B()
b?.f()
b = nil

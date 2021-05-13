// 单例模式中的内存管理

class Singleton {
    static let shared = Singleton()

    var a: A?
}

class A {
    init() {
        print("初始化\(self)")

        Singleton.shared.a = self
    }

    deinit {
        print("释放\(self)")
    }
}

var a: A? = A()
a = nil

Singleton.shared.a = nil

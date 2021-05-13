// 代理模式中的循环引用

protocol ADelegate: AnyObject {

}

class A {
    // weak
    weak var delegate: ADelegate?
}

class B: ADelegate {
    var a = A()

    init() {
        print("初始化\(self)")

        a.delegate = self
    }

    deinit {
        print("释放\(self)")
    }
}

var b: B? = B()
b = nil

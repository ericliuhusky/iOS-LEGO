@objc public class ComponentA: NSObject {
    @objc public func hello() {
        print("Hello ComponentA!")
    }
    
    @objc public func useComponentBHello() {
        ComponentBAPI.helloB()
    }
}

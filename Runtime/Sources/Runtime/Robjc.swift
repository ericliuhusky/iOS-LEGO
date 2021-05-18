//
//  Robjc.swift
//  
//
//  Created by lzh on 2021/5/17.
//

import ObjectiveC

public typealias RNSObject = NSObject

/// 使用Runtime进行某些操作
open class Robjc {
    // Runtime要求必须实现 methodSignatureForSelector 和 doesNotRecognizeSelector
    // 继承NSObject可以实现以上两个方法
    /// 创建新的类和它对应的元类
    open class func allocateClass(_ superClass: AnyClass?, name: String) -> AnyClass? {
        return objc_allocateClassPair(superClass, name, 0)
    }
    
    /// 销毁一个类和它对应的元类
    open class func disposeClass(_ cls: AnyClass) {
        objc_disposeClassPair(cls)
    }
    
    /// 创建类并添加完Ivar和Method之后注册类，注册之后才能得到它
    open class func registerClass(_ cls: AnyClass) {
        objc_registerClassPair(cls)
    }
    
    /// 根据类名获取类
    open class func getClass(_ name: String) -> AnyClass? {
//        objc_getClass(<#T##name: UnsafePointer<CChar>##UnsafePointer<CChar>#>) -> Any!
//        objc_getRequiredClass(<#T##name: UnsafePointer<CChar>##UnsafePointer<CChar>#>) -> AnyClass
        return objc_lookUpClass(name)
    }
    
    /// 根据类名获取元类
    open class func getMetaClass(_ name: String) -> Any! {
        return objc_getMetaClass(name)
    }
    
    // 有些类并不继承于NSObject，Runtime会崩溃退出
    class func getClassList() {
//        // total number of registered classes
//        let totalNum = objc_getClassList(nil, 0)
//        print(totalNum)
//        let classes = AutoreleasingUnsafeMutablePointer<AnyClass>(UnsafeMutablePointer<AnyClass>.allocate(capacity: Int(totalNum)))
//        objc_getClassList(classes, totalNum)
//        print(classes)
//        for i in 0..<totalNum {
//            print(classes[Int(i)])
//        }
//        objc_copyClassList(<#T##outCount: UnsafeMutablePointer<UInt32>?##UnsafeMutablePointer<UInt32>?#>)
    }
    
}

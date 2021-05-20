//
//  Rclass.swift
//  
//
//  Created by lzh on 2021/5/17.
//

import ObjectiveC

/// 使用Runtime根据class进行某些操作
open class Rclass {
    /// 类名
    open class func getName(_ cls: AnyClass?) -> String {
        return String(cString: class_getName(cls))
    }
    
    // Swift中类默认继承自SwiftObject，打印出来是_TtCs12_SwiftObject
    // 显示声明继承于NSObject后，那么类继承于NSObject而不继承于SwiftObject
    /// 父类
    open class func getSuperclass(_ cls: AnyClass?) -> AnyClass? {
        return class_getSuperclass(cls)
    }
    
    // 对象是类的实例，而类本身也是对象，它是元类的实例
    /// 判断是否是元类型
    open class func isMetaClass(_ cls: AnyClass?) -> Bool {
        return class_isMetaClass(cls)
    }
    
    /// 类的实例占用字节空间
    open class func getInstanceSize(_ cls: AnyClass?) -> Int {
        return class_getInstanceSize(cls)
    }
    
    /// 类的实例变量描述
    open class func getInstanceVariable(_ cls: AnyClass?, name: String) -> Rivar? {
        return Rivar(class_getInstanceVariable(cls, name))
    }
    
    class func getClassVariable() {}
    
    class func addIvar() {}
    
    /// 类变量描述列表
    open class func getIvarList(_ cls: AnyClass?) -> [Rivar] {
        var ivarList = [Rivar]()
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(cls, &outCount)
        for i in 0..<outCount {
            if let ivar = ivars?[Int(i)] {
                ivarList.append(Rivar(ivar))
            }
        }
        free(ivars)
        return ivarList
    }
    
    /// 类属性
    /// - parameter cls: 必须要声明标记为 `@objcMembers`
    open class func getProperty(_ cls: AnyClass?, name: String) -> Rproperty? {
        return Rproperty(class_getProperty(cls, name))
    }
    
    /// 类属性列表
    /// - parameter cls: 必须要声明标记为 `@objcMembers`
    open class func getPropertyList(_ cls: AnyClass?) -> [Rproperty] {
        var propertyList = [Rproperty]()
        var outCount: UInt32 = 0
        let properties = class_copyPropertyList(cls, &outCount)
        for i in 0..<outCount {
            if let property = properties?[Int(i)] {
                propertyList.append(Rproperty(property))
            }
        }
        free(properties)
        return propertyList
    }
    
    /// 类添加属性
    open class func addProperty(_ cls: AnyClass?, name: String, type: String) -> Bool {
        let nonatomic = objc_property_attribute_t(name: "N", value: "")
        let strong = objc_property_attribute_t(name: "&", value: "")
        let type = objc_property_attribute_t(name: "T", value: "@\"\(type)\"")
        let ivar = objc_property_attribute_t(name: "V", value: "_\(name)")
        let arrtibutes = [nonatomic, strong, type, ivar]
        
        return class_addProperty(cls, name, arrtibutes, UInt32(arrtibutes.count))
    }
    
    // TODO: Method, Protocal, layout
}

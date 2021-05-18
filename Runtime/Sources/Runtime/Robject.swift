//
//  Robject.swift
//  
//
//  Created by lzh on 2021/5/18.
//

import ObjectiveC

/// 使用Runtime根据object进行某些操作
open class Robject {
    // swift中返回的是一个虚假Ivar，不支持如此操作了
    class func getIvar() {
//        object_getIvar(<#T##obj: Any?##Any?#>, <#T##ivar: Ivar##Ivar#>)
    }
    
    // swift中返回的是一个虚假Ivar，不支持如此操作了
    class func setIvar() {
//        object_setIvar(<#T##obj: Any?##Any?#>, <#T##ivar: Ivar##Ivar#>, <#T##value: Any?##Any?#>)
    }
    
    /// 类名
    open class func getClassName(_ obj: Any?) -> String {
        return String(cString: object_getClassName(obj))
    }
    
    /// 类
    open class func getClass(_ obj: Any?) -> AnyClass? {
        return object_getClass(obj)
    }
}

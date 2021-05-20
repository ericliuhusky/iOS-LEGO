//
//  Rkvc.swift
//  
//
//  Created by lzh on 2021/5/20.
//

import Foundation

// KVC基于Objective-C Runtime和NSObject
// 因此无法处理属性值为可选型的情况，遇到属性为Optional会崩溃
// 因此想要实现KVC的属性需要声明为@objc
// 或者声明类为@objcMembers，那么类成员都会自动加上@objc声明

/// NS Key Value Coding (KVC)
open class Rkvc {
    /// 通过关键字获取属性的值
    open class func getValue(_ obj: NSObject?, key: String) -> Any? {
        return obj?.value(forKey: key)
    }
    
    /// 为名为关键字的属性设置值
    open class func setValue(_ obj: NSObject?, value: Any?, key: String) {
        obj?.setValue(value, forKey: key)
    }
}

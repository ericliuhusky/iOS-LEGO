//
//  Rutil.swift
//  
//
//  Created by lzh on 2021/5/20.
//

import Foundation

/// Objective-C Runtime Utilities Interact with the Objective-C runtime
open class Rutil {
    /// 获取类名
    open class func getNameFromClass(_ cls: AnyClass) -> String {
        return NSStringFromClass(cls)
    }
    
    /// 通过类名获取类
    open class func getClassFromName(_ name: String) -> AnyClass? {
        return NSClassFromString(name)
    }
}

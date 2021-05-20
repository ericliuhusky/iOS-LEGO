//
//  Dmirror.swift
//  
//
//  Created by lzh on 2021/5/20.
//

/// 封装镜像
open class Dmirror {
    var subject: Any
    
    public init(reflecting subject: Any) {
        self.subject = subject
    }
    
    /// 获取属性字典
    open func getPropertyDictionary() -> [String: Any] {
        var propDict = [String: Any]()
        
        // 递归
        func recursion(_ mirror: Mirror) {
            mirror.children.forEach { child in
                // case 模式匹配
                if case let (label?, value) = child {
                    
                    // 如果类的属性是复杂类型(结构体或类)，那么它的属性也需要展开，因此递归它的属性
                    recursion(Mirror(reflecting: value))
                    
                    // 使用类名+属性名的方式来区别父类和子类的属性值，其实树形结构比字典更加合适作为获取所有属性的返回值
                    propDict["\(mirror.subjectType).\(label)"] = value
                }
            }

            // 如果类继承自一个父类，那么它的父类的属性也需要获得，因此递归它的父类
            if let superclassMirror =  mirror.superclassMirror {
                recursion(superclassMirror)
            }
        }
        // 递归开始
        recursion(Mirror(reflecting: subject))
        
        return propDict
    }
    
    /// 根据关键字获取属性值
    open func getValue(for key: String) -> Any? {
        return getPropertyDictionary()[key]
    }
}

// 遵循自定义反射协议，设置自定义customMirror
extension Dmirror: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(reflecting: subject)
    }
}

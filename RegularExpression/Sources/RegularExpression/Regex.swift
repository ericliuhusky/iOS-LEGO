//
//  Regex.swift
//  
//
//  Created by lzh on 2021/8/17.
//

/// 正则表达式
public struct Regex<Base> {
    // 正则表达式基类
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

/// 可进行正则表达式的协议
public protocol RegexCompatible {
    associatedtype Base
    
    var regex: Regex<Base> { get }
}

extension RegexCompatible {
    /// 正则表达式扩展
    public var regex: Regex<Self> {
        Regex(self)
    }
}

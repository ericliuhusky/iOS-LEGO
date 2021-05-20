//
//  Dlanguage.swift
//  
//
//  Created by lzh on 2021/5/20.
//

// 为动态语言提供的动态支持
// Dynamic Support for Dynamic Language

import JavaScriptCore

/// JavaScript Object Notation 动态成员查询
@dynamicMemberLookup
enum JSON {
    case int(Int)
    case string(String)
    case array(Array<JSON>)
    case dictionary(Dictionary<String, JSON>)
    
    var int: Int? {
        // case 模式匹配
        if case .int(let i) = self {
            return i
        }
        return nil
    }
    
    var string: String? {
        if case .string(let str) = self {
            return str
        }
        return nil
    }
    
    // 为array类型的JSON提供[0]下标数字索引访问
    subscript(index: Int) -> JSON? {
        if case .array(let arr) = self {
            // 判断数组越界
            return (index >= 0 && index < arr.count) ? arr[index] : nil
        }
        return nil
    }
    
    // 为dictionary类型的JSON提供[""]下标字符串访问
    subscript(key: String) -> JSON? {
        if case .dictionary(let dict) = self {
            return dict[key]
        }
        return nil
    }

    // 使用@dynamicMemberLookup为dictionary类型的JSON提供除了 obj["a"] 下标字符串访问之外的更优雅的 obj.a 访问选择
    // 这种方式标记的类型使用.点语法访问不存在的属性，编译器不会报错，member: String即为使用点语法访问的字符串
    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionary(let dict) = self {
            return dict[member]
        }
        return nil
    }
}


/// JS函数可动态调用包装器
@dynamicCallable
struct JSFunctionWrapper {
    let value: JSValue
    
    func dynamicallyCall(withArguments args: [Any]) -> JSValue {
        value.call(withArguments: args)
    }
}

//
//  String+Number.swift
//  
//
//  Created by lzh on 2021/8/18.
//

public extension String {
    /// 判断是否字符串的每一个字符都是数字
    var isAllNumber: Bool {
        // 确保字符串不为空
        guard !isEmpty else { return false }
        // 不包含不是数字的字符
        return !contains(where: { character in
            !character.isNumber
        })
    }
    
    /// 判断字符串能否转换为整数类型
    /// "-123".isAllNumber -> false
    /// "-123".isInt -> true
    var isInt: Bool {
        Int(self) != nil
    }
}

//
//  RegexPatternOptions.swift
//  
//
//  Created by lzh on 2021/8/19.
//

import Foundation

/// 正则表达式模式OptionSet
public struct RegexPatternOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let exclude = RegexPatternOptions(rawValue: 1)
    public static let number = RegexPatternOptions(rawValue: 1 << 1)
    public static let letter = RegexPatternOptions(rawValue: 1 << 2)
    public static let chinese = RegexPatternOptions(rawValue: 1 << 3)
    
    /// 使用正则表达式OptionSet构造正则表达式
    var regularExpression: NSRegularExpression? {
        var pattern = ""
        if contains(.exclude) {
            pattern += "^"
        }
        if contains(.number) {
            pattern += "0-9"
        }
        if contains(.letter) {
            pattern += "a-zA-Z"
        }
        if contains(.chinese) {
            pattern += #"\u4e00-\u9fa5"#
        }
        pattern = "[\(pattern)]+"
        return try? NSRegularExpression(pattern: pattern)
    }
}

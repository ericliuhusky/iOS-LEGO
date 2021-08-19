//
//  RegularExpression.swift
//  
//
//  Created by lzh on 2021/8/19.
//

import Foundation

/// 封装NSRegularExpression正则表达式
struct RegularExpression {
    /// 模式字符串的正则表达式
    let regex: NSRegularExpression
    
    init(_ regex: NSRegularExpression) {
        self.regex = regex
    }
    
    /// 字符串中匹配模式字符串的所有子字符串
    /// - Parameter string: 被匹配的字符串
    /// - Returns: 匹配结果字符串数组
    func matches(in string: String) -> [String] {
        let results = regex.matches(in: string, range: NSRange(0..<string.count))
        return results.compactMap { result in
            Range(result.range, in: string)
        }.map { range in
            String(string[range])
        }
    }
    
    /// 字符串中匹配模式字符串的第一个子字符串
    /// - Parameter string: 被匹配的字符串
    /// - Returns: 匹配结果字符串
    func firstMatch(in string: String) -> String? {
        guard let result = regex.firstMatch(in: string, range: NSRange(0..<string.count)) else { return nil }
        guard let range = Range(result.range, in: string) else { return nil }
        return String(string[range])
    }
    
    /// 将字符串中匹配模式字符串的所有子字符串替换为其它字符串
    /// - Parameters:
    ///   - replacement: 替换的字符串
    ///   - string: 被匹配的字符串
    /// - Returns: 替换完成后的新字符串
    func replacingMatches(with replacement: String, in string: String) -> String {
        let nsstring = NSMutableString(string: string)
        regex.replaceMatches(in: nsstring, range: NSRange(0..<string.count), withTemplate: replacement)
        return String(nsstring)
    }
    
    /// 字符串与模式字符串是否完全匹配
    /// - Parameter pattern: 被匹配的字符串
    /// - Returns: 判断结果
    func isMatchedCompletely(in string: String) -> Bool {
        firstMatch(in: string)?.count == string.count
    }
}

//
//  String+Regex.swift
//  
//
//  Created by lzh on 2021/8/18.
//

import Foundation

extension String: RegexCompatible {}

// Tips: 可以使用#""#来表示真实字符串，内部的\转义字符不会被转义
// "zx3".regex.firstMatch(pattern: #"zx\d"#)

// MARK: - 模式字符串

extension Regex where Base == String {
    /// 字符串中匹配模式字符串的所有子字符串
    /// - Parameter pattern: 模式字符串
    /// - Returns: 匹配结果字符串数组
    public func matches(pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        return RegularExpression(regex).matches(in: base)
    }
    
    /// 字符串中匹配模式字符串的第一个子字符串
    /// - Parameter pattern: 模式字符串
    /// - Returns: 匹配结果字符串
    public func firstMatch(pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        return RegularExpression(regex).firstMatch(in: base)
    }
    
    /// 将字符串中匹配模式字符串的所有子字符串替换为其它字符串
    /// - Parameters:
    ///   - pattern: 模式字符串
    ///   - replacement: 替换的字符串
    /// - Returns: 替换完成后的新字符串
    public func replacingMatches(pattern: String, with replacement: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return base }
        return RegularExpression(regex).replacingMatches(with: replacement, in: base)
    }
    
    /// 字符串与模式字符串是否完全匹配
    /// - Parameter pattern: 模式字符串
    /// - Returns: 判断结果
    public func isMatchedCompletely(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        return RegularExpression(regex).isMatchedCompletely(in: base)
    }
}

// MARK: - 模式OptionSet

extension Regex where Base == String {
    /// 字符串中匹配模式字符串的所有子字符串
    /// - Parameter pattern: 正则表达式模式OptionSet
    /// - Returns: 匹配结果字符串数组
    public func matches(pattern: RegexPatternOptions) -> [String] {
        guard let regex = pattern.regularExpression else { return [] }
        return RegularExpression(regex).matches(in: base)
    }
    
    /// 字符串中匹配模式字符串的第一个子字符串
    /// - Parameter pattern: 正则表达式模式OptionSet
    /// - Returns: 匹配结果字符串
    public func firstMatch(pattern: RegexPatternOptions) -> String? {
        guard let regex = pattern.regularExpression else { return nil }
        return RegularExpression(regex).firstMatch(in: base)
    }
    
    /// 将字符串中匹配模式字符串的所有子字符串替换为其它字符串
    /// - Parameters:
    ///   - pattern: 正则表达式模式OptionSet
    ///   - replacement: 替换的字符串
    /// - Returns: 替换完成后的新字符串
    public func replacingMatches(pattern: RegexPatternOptions, with replacement: String) -> String {
        guard let regex = pattern.regularExpression else { return base }
        return RegularExpression(regex).replacingMatches(with: replacement, in: base)
    }
    
    /// 字符串与模式字符串是否完全匹配
    /// - Parameter pattern: 正则表达式模式OptionSet
    /// - Returns: 判断结果
    public func isMatchedCompletely(pattern: RegexPatternOptions) -> Bool {
        guard let regex = pattern.regularExpression else { return false }
        return RegularExpression(regex).isMatchedCompletely(in: base)
    }
}

// MARK: - NSDataDetector CheckingType

extension Regex where Base == String {
    /// 字符串中匹配模式字符串的所有子字符串
    /// - Parameter pattern: NSDataDetector的检查结果类型OptionSet
    /// - Returns: 匹配结果字符串数组
    public func matches(types: NSTextCheckingResult.CheckingType) -> [String] {
        guard let regex = try? NSDataDetector(types: types.rawValue) else { return [] }
        return RegularExpression(regex).matches(in: base)
    }
    
    /// 字符串中匹配模式字符串的第一个子字符串
    /// - Parameter pattern: NSDataDetector的检查结果类型OptionSet
    /// - Returns: 匹配结果字符串
    public func firstMatch(types: NSTextCheckingResult.CheckingType) -> String? {
        guard let regex = try? NSDataDetector(types: types.rawValue) else { return nil }
        return RegularExpression(regex).firstMatch(in: base)
    }
    
    /// 将字符串中匹配模式字符串的所有子字符串替换为其它字符串
    /// - Parameters:
    ///   - pattern: NSDataDetector的检查结果类型OptionSet
    ///   - replacement: 替换的字符串
    /// - Returns: 替换完成后的新字符串
    public func replacingMatches(types: NSTextCheckingResult.CheckingType, with replacement: String) -> String {
        guard let regex = try? NSDataDetector(types: types.rawValue) else { return base }
        return RegularExpression(regex).replacingMatches(with: replacement, in: base)
    }
    
    /// 字符串与模式字符串是否完全匹配
    /// - Parameter pattern: NSDataDetector的检查结果类型OptionSet
    /// - Returns: 判断结果
    public func isMatchedCompletely(types: NSTextCheckingResult.CheckingType) -> Bool {
        guard let regex = try? NSDataDetector(types: types.rawValue) else { return false }
        return RegularExpression(regex).isMatchedCompletely(in: base)
    }
}

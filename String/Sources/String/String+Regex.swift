//
//  String+Regex.swift
//  
//
//  Created by lzh on 2021/7/12.
//

import RegularExpression

public extension String {
    func matches(pattern: String) -> [String] {
        return RegularExpression.matchesString(pattern: pattern, in: self)
    }
    
    func firstMatch(pattern: String) -> String? {
        return RegularExpression.firstMatchString(pattern: pattern, in: self)
    }
    
    func replacedMatches(pattern: String, replacement: String) -> String {
        return RegularExpression.replacedMatches(pattern: pattern, replacement: replacement, in: self)
    }
}

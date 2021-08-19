//
//  String+Compare.swift
//  
//
//  Created by lzh on 2021/8/17.
//

import Foundation

public extension String {
    /// 比较版本号
    /// - Parameter aString: 版本号，例如 1.1.0
    /// - Returns: 比较结果
    func compareVersion(_ aString: String) -> ComparisonResult {
        // 版本号字符串分割并映射为整型数组
        let numberArray = self.split(separator: ".").map { sub in
            Int(sub) ?? 0
        }
        let anotherArray = aString.split(separator: ".").map { sub in
            Int(sub) ?? 0
        }
        let numberCount = numberArray.count
        let anotherCount = anotherArray.count

        // 逐一比较各位数字
        for i in 0..<max(numberCount, anotherCount) {
            // 尾部没有数字补0
            let number = i < numberCount ? numberArray[i] : 0
            let another = i < anotherCount ? anotherArray[i] : 0

            if number != another {
                return number < another ? .orderedAscending : .orderedDescending
            }
        }

        return .orderedSame
    }
    
    /// 判断大小写不敏感时，两个字符串是否相等
    /// - Parameter aString: 另一个字符串
    /// - Returns: 比较结果
    func caseInsensitiveEqual(_ aString: String) -> Bool {
        self.caseInsensitiveCompare(aString) == .orderedSame
    }
}

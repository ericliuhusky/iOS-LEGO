//
//  String+Index.swift
//  
//
//  Created by lzh on 2021/8/19.
//

public extension String {
    /// 字符串整型下标访问
    /// string[0]
    subscript(i: Int) -> Character {
        get {
            let index = index(startIndex, offsetBy: i)
            return self[index]
        }

        set {
            let index = index(startIndex, offsetBy: i)
            replaceSubrange(index...index, with: String(newValue))
        }
    }

    /// 字符串整型开区间下标访问
    /// string[0..<3]
    subscript(range: Range<Int>) -> Substring {
        get {
            let start = index(startIndex, offsetBy: range.startIndex)
            let end = index(startIndex, offsetBy: range.endIndex)
            return self[start..<end]
        }

        set {
            let start = index(startIndex, offsetBy: range.startIndex)
            let end = index(startIndex, offsetBy: range.endIndex)
            replaceSubrange(start..<end, with: String(newValue))
        }
    }
    
    /// 字符串整型闭区间下标访问
    /// string[0...3]
    subscript(range: ClosedRange<Int>) -> Substring {
        get {
            let start = index(startIndex, offsetBy: range.lowerBound)
            let end = index(startIndex, offsetBy: range.upperBound)
            return self[start...end]
        }

        set {
            let start = index(startIndex, offsetBy: range.lowerBound)
            let end = index(startIndex, offsetBy: range.upperBound)
            replaceSubrange(start...end, with: String(newValue))
        }
    }
}


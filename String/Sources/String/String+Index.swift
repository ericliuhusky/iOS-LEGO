//
//  String+Index.swift
//  
//
//  Created by lzh on 2021/7/9.
//

public extension String {
    subscript(integer: Int) -> Character {
        get {
            let resultIndex = index(startIndex, offsetBy: integer)
            return self[resultIndex]
        }
        
        set {
            let resultIndex = index(startIndex, offsetBy: integer)
            self.replaceSubrange(resultIndex..<index(after: resultIndex), with: String(newValue))
        }
    }
}

//
//  String+Number.swift
//  
//
//  Created by lzh on 2021/7/9.
//

public extension String {
    var isAllNumber: Bool {
        !contains(where: { character in
            !character.isNumber
        })
    }
    
    var isInt: Bool {
        Int(self) != nil
    }
}

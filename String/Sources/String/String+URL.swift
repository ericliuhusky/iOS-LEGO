//
//  String+URL.swift
//  
//
//  Created by lzh on 2021/7/9.
//

import Foundation

public extension String {
    init(param: [String: Any]) {
        let paramArray = param.map { key, value in
            return "\(key)=\(value)"
        }
        self = paramArray.joined(separator: "&")
    }
    
    var param: [String: Any] {
        var dictionary = [String: Any]()
        let paramArray = self.split(separator: "&")
        paramArray.forEach { param in
            let keyValuePair = param.split(separator: "=")
            let key = String(keyValuePair[0])
            let value = String(keyValuePair[1])
            dictionary[key] = value
        }
        return dictionary
    }
    
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var urlDecoded: String {
        return removingPercentEncoding ?? ""
    }
}

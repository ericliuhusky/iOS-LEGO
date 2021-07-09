//
//  String+URL.swift
//  
//
//  Created by lzh on 2021/7/9.
//

extension Dictionary {
    var paramString: String {
        let paramArray = self.map { key, value in
            return "\(key)=\(value)"
        }
        return paramArray.joined(separator: "&")
    }
}

//print(["a":1, "b":"我去"].paramString)
//print([String: String].init(param: "b=我去&a=1"))

extension Dictionary where Key == String, Value == String {
    init(param: String) {
        self.init()
        let paramArray = param.split(separator: "&")
        paramArray.forEach { param in
            let keyValuePair = param.split(separator: "=")
            let key = String(keyValuePair[0])
            let value = String(keyValuePair[1])
            self[key] = value
        }
    }
}

public extension String {
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var urlDecoded: String {
        return removingPercentEncoding ?? ""
    }
}

//print("六".urlEncoded)
//print("%E5%85%AD".urlDecoded)

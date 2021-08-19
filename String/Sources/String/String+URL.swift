//
//  String+URL.swift
//
//
//  Created by lzh on 2021/8/19.
//

public extension String {
    /// 使用URL查询参数构建URL编码的查询字符串
    /// - Parameter parameters: 查询参数字典
    init(parameters: [String: Any]) {
        self = parameters.compactMap { key, value in
            "\(key)=\(value)".urlEncoded
        }.joined(separator: "&")
    }
    
    /// 获取URL查询字符串对应的URL解码的查询参数字典
    var parameters: [String: String] {
        var dict = [String: String]()
        self.split(separator: "&").forEach { pairs in
            let pairs = pairs.split(separator: "=")
            let key = String(pairs[0])
            let value = pairs.count == 2 ? String(pairs[1]) : ""
            dict[key] = value.urlDecoded
        }
        return dict
    }
    
    /// URL编码的字符串
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// URL解码的字符串
    var urlDecoded: String? {
        removingPercentEncoding
    }
}

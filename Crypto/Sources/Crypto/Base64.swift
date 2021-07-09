//
//  Base64.swift
//  
//
//  Created by lzh on 2021/7/9.
//

import Foundation

extension Crypto {
    public struct Base64 {
        public static func encodedData(_ data: Data) -> Data {
            return data.base64EncodedData()
        }
        
        public static func encodedString(_ data: Data) -> String {
            return data.base64EncodedString()
        }
        
        public static func decodedData(_ data: Data) -> Data {
            return Data(base64Encoded: data) ?? Data()
        }
        
        public static func decodedData(_ data: String) -> Data {
            return Data(base64Encoded: data) ?? Data()
        }
        
        
        
        public static func encodedData(_ data: String) -> Data {
            let data = data.data(using: .utf8) ?? Data()
            return encodedData(data)
        }
        
        public static func encodedString(_ data: String) -> String {
            let data = data.data(using: .utf8) ?? Data()
            return encodedString(data)
        }
        
        public static func decodedString(_ data: Data) -> String {
            let data = decodedData(data)
            return String(data: data, encoding: .utf8) ?? ""
        }
        
        public static func decodedString(_ data: String) -> String {
            let data = decodedData(data)
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
}

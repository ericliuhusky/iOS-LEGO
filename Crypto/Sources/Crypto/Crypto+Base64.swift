//
//  Crypto+Base64.swift
//  BBFoundation_Swift
//
//  Created by lzh on 2021/8/12.
//

import Foundation

extension Crypto {
    public struct Base64<Raw> {
        let raw: Raw
        
        init(_ raw: Raw) {
            self.raw = raw
        }
        
        /// Base64编码
        /// - Parameter data: 原始数据
        /// - Returns: 编码数据
        func encode(_ data: Data) -> Data {
            data.base64EncodedData()
        }
        
        /// Base64解码
        /// - Parameter data: 原始数据
        /// - Returns: 解码数据
        func decode(_ data: Data) -> Data {
            Data(base64Encoded: data) ?? Data()
        }
    }
    
    /// Base64编码
    public var base64: Base64<Raw> {
        Base64(raw)
    }
}

// MARK: - 当原始数据为Data时

extension Crypto.Base64 where Raw == Data {
    /// 编码后的数据
    public var encodedData: Data {
        encode(raw)
    }
    
    /// 编码后的字符串
    public var encodedString: String {
        raw.base64EncodedString()
    }
    
    /// 解码后的数据
    public var decodedData: Data {
        decode(raw)
    }
    
    /// 解码后的字符串
    public var decodedString: String {
        String(data: decode(raw), encoding: .utf8) ?? ""
    }
}

// MARK: - 当原始数据为String时

extension Crypto.Base64 where Raw == String {
    /// 编码后的数据
    public var encodedData: Data {
        guard let data = raw.data(using: .utf8) else { return Data() }
        return encode(data)
    }
    
    /// 编码后的字符串
    public var encodedString: String {
        guard let data = raw.data(using: .utf8) else { return "" }
        return data.base64EncodedString()
    }
    
    /// 解码后的数据
    public var decodedData: Data {
        guard let data = raw.data(using: .utf8) else { return Data() }
        return decode(data)
    }
    
    /// 解码后的字符串
    public var decodedString: String {
        guard let data = raw.data(using: .utf8) else { return "" }
        return String(data: decode(data), encoding: .utf8) ?? ""
    }
}

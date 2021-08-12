//
//  MD5+Crypto.swift
//  BBFoundation_Swift
//
//  Created by lzh on 2021/8/11.
//

import Foundation
import CryptoKit
import CommonCrypto

extension Crypto {
    public struct MD5<Raw> {
        let raw: Raw
        
        init(_ raw: Raw) {
            self.raw = raw
        }
        
        /// MD5哈希函数
        /// - Parameter data: 原始数据
        /// - Returns: 哈希计算后的数据
        func hash(_ data: Data) -> Data {
            if #available(macOS 10.15, iOS 13.0, *) {
                let digest = Insecure.MD5.hash(data: data)
                return Data(digest: digest)
            } else {
                var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                data.withUnsafeBytes { p in
                    CC_MD5(p.baseAddress, CC_LONG(data.count), &digest)
                }
                return Data(digest: digest)
            }
        }
    }
    
    /// MD5哈希
    public var md5: MD5<Raw> {
        MD5(raw)
    }
}

// MARK: - 当原始数据为Data时

extension Crypto.MD5 where Raw == Data {
    /// 哈希计算后的数据
    public var hashedData: Data {
        hash(raw)
    }
    
    /// 哈希计算后的字符串
    public var hashedString: String {
        String(digest: hash(raw))
    }
}

// MARK: - 当原始数据为String时

extension Crypto.MD5 where Raw == String {
    /// 哈希计算后的数据
    public var hashedData: Data {
        guard let data = raw.data(using: .utf8) else { return Data() }
        return hash(data)
    }
    
    /// 哈希计算后的字符串
    public var hashedString: String {
        guard let data = raw.data(using: .utf8) else { return "" }
        return String(digest: hash(data))
    }
}

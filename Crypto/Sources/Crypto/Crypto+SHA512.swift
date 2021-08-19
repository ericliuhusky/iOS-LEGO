//
//  Crypto+SHA512.swift
//  
//
//  Created by lzh on 2021/8/12.
//

import Foundation
import CryptoKit
import CommonCrypto

extension Crypto {
    public struct SHA512<Raw> {
        let raw: Raw
        
        init(_ raw: Raw) {
            self.raw = raw
        }
        
        /// SHA512哈希函数
        /// - Parameter data: 原始数据
        /// - Returns: 哈希计算后的数据
        func hash(_ data: Data) -> Data {
            if #available(macOS 10.15, iOS 13.0, *) {
                let digest = CryptoKit.SHA512.hash(data: data)
                return Data(digest: digest)
            } else {
                var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
                data.withUnsafeBytes { p in
                    CC_SHA512(p.baseAddress, CC_LONG(data.count), &digest)
                }
                return Data(digest: digest)
            }
        }
    }
    
    /// SHA512哈希
    public var sha512: SHA512<Raw> {
        SHA512(raw)
    }
}

// MARK: - 当原始数据为Data时

extension Crypto.SHA512 where Raw == Data {
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

extension Crypto.SHA512 where Raw == String {
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

//
//  MD5.swift
//  
//
//  Created by lzh on 2021/7/9.
//

import CryptoKit
import CommonCrypto

extension Crypto {
    public struct MD5 {
        public static func hashedData<D>(_ data: D) -> CryptoData where D: CryptoDataProtocol {
            if #available(macOS 10.15, *) {
                let digest = Insecure.MD5.hash(data: data)
                return CryptoData(digest: digest)
            } else {
                var data = data
                var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                CC_MD5(&data, CC_LONG(data.count), &digest)
                return CryptoData(digest: digest)
            }
        }
        
        public static func hashedString<D>(_ data: D) -> String where D: CryptoDataProtocol {
            let data = hashedData(data)
            return String(digest: data)
        }
        
        
        
        public static func hashedData(_ data: String) -> CryptoData {
            let data = data.data(using: .utf8) ?? CryptoData()
            return hashedData(data)
        }
        
        public static func hashedString(_ data: String) -> String {
            let data = data.data(using: .utf8) ?? CryptoData()
            return hashedString(data)
        }
    }
}

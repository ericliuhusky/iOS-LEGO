//
//  Crypto+Extensions.swift
//  BBFoundation_Swift
//
//  Created by lzh on 2021/8/12.
//

import Foundation
import CryptoKit

extension Data {
    /// 使用哈希摘要构建数据摘要
    /// - Parameter digest: Digest摘要
    @available(macOS 10.15, iOS 13.0, *)
    init<D>(digest: D) where D: Digest {
        self = digest.reduce(Data()) { result, element in
            var result = result
            result.append(element)
            return result
        }
    }
    
    /// 使用哈希摘要构建数据摘要
    /// - Parameter digest: [UInt8]摘要
    init(digest: [UInt8]) {
        self = digest.reduce(Data()) { result, element in
            var result = result
            result.append(element)
            return result
        }
    }
}

extension String {
    /// 使用哈希摘要构建字符串摘要
    /// - Parameter digest: Data摘要
    init(digest: Data) {
        self = digest.reduce("") { result, element in
            return result + String(format: "%02x", element)
        }
    }
}

extension String: CryptoCompatible {}
extension Data: CryptoCompatible {}

//
//  Crypto.swift
//  
//
//  Created by lzh on 2021/8/11.
//

/// 加密
public struct Crypto<Raw> {
    // 原始数据
    let raw: Raw
    
    init(_ raw: Raw) {
        self.raw = raw
    }
}

/// 可加密的协议
public protocol CryptoCompatible {
    associatedtype Raw
    
    var crypto: Crypto<Raw> { get }
}

extension CryptoCompatible {
    /// 加密扩展
    public var crypto: Crypto<Self> {
        Crypto(self)
    }
}

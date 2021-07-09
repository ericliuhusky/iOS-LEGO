//
//  Extensions.swift
//  
//
//  Created by lzh on 2021/7/9.
//

extension CryptoData {
    @available(macOS 10.15, *)
    init<D>(digest: D) where D: CryptoDigest {
        self = digest.reduce(CryptoData()) { result, element in
            var result = result
            result.append(element)
            return result
        }
    }
    
    init(digest: [UInt8]) {
        self = digest.reduce(CryptoData()) { result, element in
            var result = result
            result.append(element)
            return result
        }
    }
}

extension String {
    init(digest: CryptoData) {
        self = digest.reduce("") { result, element in
            return result + String(format: "%02x", element)
        }
    }
}

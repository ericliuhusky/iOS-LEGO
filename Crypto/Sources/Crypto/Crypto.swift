import CryptoKit
import CommonCrypto
import Foundation

struct Crypto {
    static func MD5<D>(_ data: D) -> String where D: DataProtocol {
        if #available(macOS 10.15, *) {
            let digest = Insecure.MD5.hash(data: data)
            return String(digest: digest)
        } else {
            var data = data
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(&data, CC_LONG(data.count), &digest)
            return String(digest: digest)
        }
    }
    
    static func SHA1<D>(_ data: D) -> String where D: DataProtocol {
        if #available(macOS 10.15, *) {
            let digest = Insecure.SHA1.hash(data: data)
            return String(digest: digest)
        } else {
            var data = data
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(&data, CC_LONG(data.count), &digest)
            return String(digest: digest)
        }
    }
}


extension String {
    @available(macOS 10.15, *)
    init<D>(digest: D) where D: Digest {
        self = digest.reduce("") { result, element in
            return result + String(format: "%02x", element)
        }
    }
    
    init(digest: [UInt8]) {
        self = digest.reduce("") { result, element in
            return result + String(format: "%02x", element)
        }
    }
}

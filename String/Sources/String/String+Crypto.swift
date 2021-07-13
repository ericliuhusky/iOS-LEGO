//
//  String+Crypto.swift
//  
//
//  Created by lzh on 2021/7/13.
//

import Crypto

public extension String {
    var base64Encoded: String {
        Crypto.Base64.encodedString(self)
    }
    
    var base64Decoded: String {
        Crypto.Base64.decodedString(self)
    }
    
    var md5Hashed: String {
        Crypto.MD5.hashedString(self)
    }
    
    var sha1Hashed: String {
        Crypto.SHA1.hashedString(self)
    }
}

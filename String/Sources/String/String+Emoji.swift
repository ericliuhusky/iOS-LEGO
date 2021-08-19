//
//  String+Emoji.swift
//  
//
//  Created by lzh on 2021/8/17.
//

public extension Character {
    /// 判断字符是否是emoji
    var isEmoji: Bool {
        // 有一些emoji字符是单个emoji，有一些是多个emoji字符组合拼接而成的如🇨🇳 = 🇨 + 🇳
        // 单个emoji字符的第一个标量是它自身一定是emoji，多个emoji字符的第一个标量也一定是emoji，如🇨🇳的🇨是emoji
        // 因此只需判断第一个标量是否是emoji
        
        guard let firstScalar = unicodeScalars.first else { return false }
        
        if #available(macOS 10.12.2, iOS 10.2, *) {
            // isEmoji判断是否拥有emoji的展示形式，(0-9*#♂♀©®)等非emoji字符也拥有emoji的展示形式
            // isEmojiPresentation判断是否默认以emoji形式展示，非默认以emoji形式展示的字符也会以emoji的形式展示
            //
            // 因此只要有emoji展示形式，有可能是emoji的特殊符号全部判断为真；
            // 再维护一个常用字符列表，排除常用字符
            
            let commonScalars = "0123456789*#♂♀©®".unicodeScalars
            return firstScalar.properties.isEmoji && !commonScalars.contains(firstScalar)
        } else {
            /*
            // 使用10.2以上的emoji判断把所有Unicode中的emoji过滤出来
            let emojiScalars = (0...0x10FFF0).compactMap { code in
                UnicodeScalar(code)
            }.filter { scalar in
                Character(scalar).isEmoji
            }

            // 将形如\u{0001F963}的scalar映射为形如0x1F963的整型
            let emojiValues = emojiScalars.map { $0.value }

            // 将一千多个整型合并为一百多个区间
            var emojiRanges = [ClosedRange<UInt32>]()
            var left = UInt32(0)
            var right = UInt32(0)
            for value in emojiValues {
                if value != (right + 1) {
                    if left != 0 && right != 0 {
                        emojiRanges.append(left...right)
                    }
                    left = value
                }
                right = value
            }

            print(emojiRanges.description.replacingOccurrences(of: "ClosedRange", with: ""))
            */
            // 本希望通过10.2以上版本的emoji判断过滤出所有的emoji字符，并将其化简合并为若干个区间，
            // 将区间数组复制粘贴于此处，接着判断字符是否位于区间内即可判断是否是emoji字符，这种做法可以保证10.2以上和以下版本的一致性
            // 奈何这种做法效率低下，只好忽略一些非emoji字符，只关注开头8252和结尾129730，即使内部存在非emoji字符也不关心它
            // 0x203C和0x1FAC2是8252和129730的十六进制表示
            // 这种判断会将大量8252-129730区间内的大量非emoji字符也判断为emoji
            
            return (0x203C...0x1FAC2).contains(firstScalar.value)
        }
    }
}

public extension String {
    /// 判断字符串是否包含emoji字符
    var containsEmoji: Bool {
        contains { character in
            character.isEmoji
        }
    }
    
    /// 删除所有emoji的新字符串，注意是删除所有而不是只去除首尾的trimming
    var removingEmojis: String {
        filter { character in
            !character.isEmoji
        }
    }
}

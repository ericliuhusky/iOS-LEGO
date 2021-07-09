//
//  String+Emoji.swift
//  
//
//  Created by lzh on 2021/7/9.
//

public extension Character {
    @available(macOS 10.12.2, *)
    var isEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmojiPresentation
    }
}

public extension String {
    @available(macOS 10.12.2, *)
    var isAllEmoji: Bool {
        !contains(where: { character in
            !character.isEmoji
        })
    }
    
    @available(macOS 10.12.2, *)
    var containsEmoji: Bool {
        contains { character in
            character.isEmoji
        }
    }
    
    @available(macOS 10.12.2, *)
    var emojiRemoved: String {
        filter { character in
            !character.isEmoji
        }
    }
    
    // SoftBank Unicode
}

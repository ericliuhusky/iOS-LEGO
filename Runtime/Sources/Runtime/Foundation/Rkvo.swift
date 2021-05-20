//
//  Rkvo.swift
//  
//
//  Created by lzh on 2021/5/20.
//

import Foundation

// KVO基于Objective-C Runtime和NSObject
// 因此无法处理属性值为可选型的情况，遇到属性为Optional会无法观察到更新
// 因此想要实现KVO的属性需要声明为@objc
// 或者声明类为@objcMembers，那么类成员都会自动加上@objc声明
// 需要实现KVO的属性还要声明为 dynamic ，swift默认是静态派发，声明为动态派发才可以观察到更新

/// NS Key Value Observing (KVO)
open class Rkvo {
    /// 可观察对象
    open class Subject: NSObject {
        /// 封装添加观察者
        open func addObserver(_ observer: NSObject, forKeyPath keyPath: String) {
            self.addObserver(observer, forKeyPath: keyPath, options: .new, context: nil)
        }
    }
    
    /// 观察者
    open class Observer: NSObject {
        /// 封装观察到更新的回调
        open func update(subject: Subject?, state: KeyValuePairs<String?, Any?>) {
            
        }
        
        /// 观察到更新的回调
        open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            update(subject: object as? Subject, state: [keyPath: change?[.newKey]])
        }
    }
}

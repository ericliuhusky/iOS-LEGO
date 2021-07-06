//
//  AnyWhereDoorDoraemonPlugin.swift
//  DoKit
//
//  Created by lzh on 2021/7/6.
//

import DoraemonKit

/// 任意门插件
class AnyWhereDoorDoraemonPlugin: NSObject, DoraemonPluginProtocol {
    
    /// 点击插件之后的回调
    func pluginDidLoad() {
        DoraemonHomeWindow.openPlugin(AnyWhereDoorViewController())
    }
}

//
//  DoraemonManager.swift
//  DoKit
//
//  Created by lzh on 2021/7/6.
//

import DoraemonKit

/// 封装DoraemonKit
struct DoraemonManager {
    
    /// 初始化并加载自定义插件
    static func install() {
        DoraemonKit.DoraemonManager.shareInstance().install()
        customPlugins()
    }
    
    /// 自定义插件扩展，添加插件时在此处修改
    static func customPlugins() {
        addPluginWith(title: "任意门", plugin: AnyWhereDoorDoraemonPlugin.self)
    }
    
    /// 封装添加插件
    /// - Parameters:
    ///   - title: 插件名
    ///   - plugin: 插件类
    static func addPluginWith(title: String, plugin: AnyClass) {
        DoraemonKit.DoraemonManager.shareInstance()
            .addPlugin(withTitle: title,
                       icon: "doraemon_default",
                       desc: "",
                       pluginName: NSStringFromClass(plugin),
                       atModule: "多啦A梦")
    }
}

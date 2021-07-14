//
//  AppDelegate.swift
//  ComponentDemo
//
//  Created by lzh on 2021/7/14.
//

import UIKit
import BBMiddlewareAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ComponentAAPI.helloA()
        ComponentBAPI.helloB()
        ComponentAAPI.useComponentBHello()
        
        return true
    }

}


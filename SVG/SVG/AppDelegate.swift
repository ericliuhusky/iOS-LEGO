//
//  AppDelegate.swift
//  SVG
//
//  Created by lzh on 2021/6/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navi = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        
        return true
    }

}


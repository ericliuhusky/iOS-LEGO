//
//  AppDelegate.swift
//  TabBarController
//
//  Created by mc on 2021/5/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: item1
        let item1 = ViewController(title: "item1")
        let navigation1 = UINavigationController(rootViewController: item1)
        
        // MARK: item2
        let item2 = ViewController(title: "item2")
        let navigation2 = UINavigationController(rootViewController: item2)
        
        // MARK: item3
        let item3 = ViewController(title: "item3")
        let navigation3 = UINavigationController(rootViewController: item3)
        
        // MARK: item4
        let item4 = ViewController(title: "item4")
        let navigation4 = UINavigationController(rootViewController: item4)
        
        // 设置标签栏控制器的视图控制器
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [navigation1, navigation2, navigation3, navigation4]
        
        // 设置窗口的根视图控制器，并把它设置为关键窗口和可见
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return true }
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    // MARK: Application Life-Cycle
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("application: 应用即将进入前台")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("application: 应用已经进入活跃状态")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("application: 应用即将进入不活跃状态")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("application: 应用已经进入后台")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("application: 应用即将终止")
    }
}

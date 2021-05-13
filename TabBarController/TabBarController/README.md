# 日报

## 任务内容

1. 创建一个TabBarController工程，最外层是一个`UITabBarController`。TabView拥有多个TabItem，其中每个TabItem又有Navigation的功能，
因此每个TabItem应该用`UINavigationController`包裹。在TabItem中设置两个Button，分别使用`UIButton`的父类`UIControl`的`addTarget(_:action:for:)`方法
和`UITapGestureRecognizer`来触发事件，接着分别使用`UINavigationController`的`pushViewController(_:animated:)`方法和`UIViewController`的
`present(_:animated:completion:)`方法来打开页面。接着为第二个Button再添加一个`UILongPressGestureRecognizer`，并通过设置`modalPresentationStyle`
使其触发全屏present新的视图控制器

2. `AppDelegate`, `UIViewController`, `UIView` 的生命周期

## 生命周期

- ### AppDelegate
  1. applicationWillEnterForeground

        应用即将进入前台

  2. applicationDidBecomeActive

        应用已经进入活跃状态

  3. applicationWillResignActive

        应用即将进入不活跃状态

  4. applicationDidEnterBackground

        应用已经进入后台

  5. applicationWillTerminate

        应用即将终止

    应用启动后进入活跃状态；当用户下拉通知中心时进入不活跃状态；当用户双击home键进入任务管理页时进入不活跃状态；当用户单击home键返回桌面时首先进入不活跃状态，接着进入后台；
    当应用没有被kill而用户又重新点击图标打开应用时，首先进入前台，接着进入活跃状态；当用户双击home键进入任务管理页并把应用上滑手动终止应用时，首先进入不活跃状态，接着进入后台，
    最后应用终止

- ### UIViewController
  1. loadView

        加载视图

  2. viewDidLoad

        视图加载完成

  3. viewWillAppear

        视图即将显示

  4. viewWillLayoutSubviews

        视图将要布局子视图

  5. viewDidLayoutSubviews

        视图已经布局子视图

  6. viewDidAppear

        视图已经显示

  7. viewWillDisappear

        视图即将消失

  8. viewDidDisappear

        视图已经消失

  9.  willMove

        本控制器即将添加或删除到父控制器

  10. didMove

        本控制器已经添加或删除到父控制器

    当视图控制器打开时，首先加载视图，接着加载完成，接着即将显示，此时是没有画面的，等设备真的渲染完成之后，接着显示完成；
    当导航控制器的根视图控制器压入新的视图控制器时，首先加载新视图控制器的视图，加载完毕之后父视图即将消失，新视图即将显示，父视图已经消失之后新视图显示完成；
    当使用present展示新的视图控制器时，首先加载新视图控制器的视图，加载完毕之后即将显示，最终视图显示完成，此方法不会使父视图消失；
    当使用标签控制器切换标签页时，首先当前页面视图即将消失，接着加载目标标签页视图控制器的视图，加载完毕之后新视图即将显示，接着当前的页面视图消失，最终新目标页面显示完成；
    当标签页已经加载过时，再切换标签页无需再加载，首先目标页视图即将显示，接着当前页即将消失，当前页面消失以后新目标页视图显示完成；
    当页面导航返回或者下滑取消展示时，销毁控制器，先销毁控制器，再销毁子视图

- ### UIView
  1. didAddSubview

        子视图添加完成

  2. willRemoveSubview

        子视图即将删除

  3. willMove

        本视图即将添加或删除到父视图

  4. didMoveToSuperview

        本视图已经添加或删除到父视图

  5. willMove

        本视图即将添加或删除到window视图

  6. didMoveToWindow

        本视图已经添加或删除到window视图

    先初始化视图，再加载视图；先销毁控制器，再销毁子视图

## 知识总结

```swift
// 设置窗口的根视图控制器，并把它设置为关键窗口和可见
window.rootViewController = viewController
window.makeKeyAndVisible()

// TabView
let tabbarController = UITabBarController()
tabbarController.viewControllers = [viewController1, viewController2, viewController3, viewController4]

// NavigationView
let navigationController = UINavigationController(rootViewController: viewController)
navigationController.pushViewController(pushedViewController, animated: true)

// Button
let button = UIButton(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
button.addTarget(self, action: #selector(buttonTouchCallback), for: .touchUpInside)

// Tap Gesture
let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCallback))
view.addGestureRecognizer(tapGesture)

// present
presentedViewController.modalPresentationStyle = .fullScreen
viewController.present(presentedViewController, animated: true)
```

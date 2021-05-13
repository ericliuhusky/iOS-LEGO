//
//  ViewController.swift
//  TabBarController
//
//  Created by mc on 2021/5/8.
//

import UIKit

class ViewController: UIViewController {
    
    // 标识符
    var identifier: String
    
    init(title: String) {
        self.identifier = title
        super.init(nibName: nil, bundle: nil)
        self.title = title
        print("viewcontroller: 初始化控制器 \(self.identifier)")
    }
    
    required init?(coder: NSCoder) {
        self.identifier = ""
        super.init(coder: coder)
        self.view.backgroundColor = UIColor.red;
    }
    
    deinit {
        print("viewcontroller: 销毁控制器 \(self.identifier)")
    }
}

extension ViewController {
    // 内容视图
    func contentView() {
        self.view.backgroundColor = .white
        
        // MARK: Button Target Action
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        button.setTitle("push view", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTouchCallback), for: .touchUpInside)
        
        // MARK: Tap Gesture
        let button2 = UIButton(frame: CGRect(x: 100, y: 300, width: 150, height: 50))
        button2.setTitle("present view", for: .normal)
        button2.backgroundColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCallback))
        button2.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCallback))
        button2.addGestureRecognizer(longPressGesture)
        
        
        // MARK: view
        let box = View(frame: CGRect(x: 100, y: 400, width: 200, height: 200), identifier: "box")
        box.backgroundColor = .blue
        let subBox = View(frame: CGRect(x: 50, y: 50, width: 100, height: 100), identifier: "subBox")
        subBox.backgroundColor = .red
        box.addSubview(subBox)
        
        // 添加到视图
        self.view.addSubview(button)
        self.view.addSubview(button2)
        self.view.addSubview(box)
    }
    
    // button touch up inside 回调
    @objc func buttonTouchCallback() {
        let pushView = ViewController(title: "pushed new view")
        guard let navigationController = self.navigationController else { return }
        navigationController.pushViewController(pushView, animated: true)
    }
    
    // button2 tapped gesture 回调
    @objc func tappedCallback() {
        let presentView = ViewController(title: "presented new view")
        self.present(presentView, animated: true)
    }
    
    @objc func longPressCallback() {
        let presentView = ViewController(title: "presented new view")
        // 全屏present
        presentView.modalPresentationStyle = .fullScreen
        self.present(presentView, animated: true)
    }
}

extension ViewController {
    // MARK: ViewController Life-Cycle

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView()
        print("viewcontroller: 视图加载完成 \(self.identifier)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewcontroller: 视图即将显示 \(self.identifier)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewcontroller: 视图将要布局子视图 \(self.identifier)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewcontroller: 视图已经布局子视图 \(self.identifier)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewcontroller: 视图已经显示 \(self.identifier)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewcontroller: 视图即将消失 \(self.identifier)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewcontroller: 视图已经消失 \(self.identifier)")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print("viewcontroller: 本控制器即将添加或删除到父控制器 \(self.identifier)")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("viewcontroller: 本控制器已经添加或删除到父控制器 \(self.identifier)")
    }
}

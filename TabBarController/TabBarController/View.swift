//
//  View.swift
//  TabBarController
//
//  Created by mc on 2021/5/8.
//

import UIKit

class View: UIView {
    
    // 标识符
    var identifier: String
    
    init(frame: CGRect, identifier: String) {
        self.identifier = identifier
        super.init(frame: frame)
        print("view: 初始化视图 \(self.identifier)")
    }
    
    required init?(coder: NSCoder) {
        self.identifier = ""
        super.init(coder: coder)
    }
    
    deinit {
        print("view: 销毁视图 \(self.identifier)")
    }
}

extension View {
    // MARK: View Life-Cycle
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        print("view: 子视图添加完成 \(self.identifier)")
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        print("view: 子视图即将删除 \(self.identifier)")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print("view: 本视图即将添加或删除到父视图 \(self.identifier)")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print("view: 本视图已经添加或删除到父视图 \(self.identifier)")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        print("view: 本视图即将添加或删除到window视图 \(self.identifier)")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        print("view: 本视图已经添加或删除到window视图 \(self.identifier)")
    }
}

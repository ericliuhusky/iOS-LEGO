//
//  NewHelloConroller.swift
//  OC-Swift-Bridge
//
//  Created by lzh on 2021/5/21.
//

// @objc 和 open 可加可不加
@objc open class NewHelloController: HelloController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
        label.text = "hello swift"
        self.view.addSubview(label)
    }
}

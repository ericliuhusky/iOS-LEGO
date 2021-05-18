//
//  ViewController.swift
//  GSHome
//
//  Created by lzh on 2021/5/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 仅作启动用，由于不会配置纯代码Info.plist
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .black
        button.setTitle("打开", for: .normal)
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func start() {
        // 在viewDidLoad中使用会打印以下内容
        // [Presentation] Attempt to present <GSHome.HDGSMyHomeViewController: 0x7f9b6bf07560> on <GSHome.ViewController: 0x7f9b6bd09e20> (from <GSHome.ViewController: 0x7f9b6bd09e20>) whose view is not in the window hierarchy.
        let vc = HDGSMyHomeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}


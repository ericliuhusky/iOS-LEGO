//
//  ViewController.swift
//  SVG
//
//  Created by lzh on 2021/6/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(localButton)
        view.addSubview(networkButton)
    }
    
    lazy var localButton: UIButton = {
        let button = UIButton(frame: .init(x: 20, y: 100, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("本地SVG", for: .normal)
        button.addTarget(self, action: #selector(openLocal), for: .touchUpInside)
        return button
    }()
    
    @objc func openLocal() {
        navigationController?.pushViewController(LocalViewController(), animated: true)
    }
    
    lazy var networkButton: UIButton = {
        let button = UIButton(frame: .init(x: 220, y: 100, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("网络SVG", for: .normal)
        button.addTarget(self, action: #selector(openNetwork), for: .touchUpInside)
        return button
    }()
    
    @objc func openNetwork() {
        navigationController?.pushViewController(NetworkViewController(), animated: true)
    }
}


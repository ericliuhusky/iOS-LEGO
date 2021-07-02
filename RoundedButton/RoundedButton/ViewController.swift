//
//  ViewController.swift
//  RoundedButton
//
//  Created by lzh on 2021/7/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let button = RoundedButton(frame: .init(x: 100, y: 100, width: 200, height: 100))
        button.backgroundColor = .black
        
        
        button.cornerRadius(rect: .init(topLeft: 10, topRight: 20, bottomLeft: 20, bottomRight: 10))
//        button.cornerRadius(20)
        
        
        view.addSubview(button)
    }


}

